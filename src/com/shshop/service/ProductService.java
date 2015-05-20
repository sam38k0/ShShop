package com.shshop.service;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class ProductService {

	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public ProductService(HttpServletRequest request, HttpServletResponse response)
	{
		this.request = request;
		this.response = response;
	}
	
	public CommandResult insertProduct() throws IOException
	{
		CommandResult result = null;
		
		fileUpload();
		
		return result;
	}
	
	public void fileUpload() throws IOException
	{
		boolean isMultipart;
		
		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
		String repositoryPath = request.getServletContext().getInitParameter(Constant.paramFileUploadRepository);
		
		int maxFileSize = 50 * 1024;
		int maxMemSize = 10 * 1024; // √÷¥Î 1MB
		File file;
		
		isMultipart = ServletFileUpload.isMultipartContent(request); 

		if (!isMultipart)
			return;
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File(repositoryPath));

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);

		try 
		{
			List<FileItem> fileItems = upload.parseRequest(request);

			Iterator<FileItem> i = fileItems.iterator();

			while (i.hasNext()) 
			{
				FileItem fileItem = (FileItem) i.next();
				if (!fileItem.isFormField()) 
				{
					String fileName = fileItem.getName();
					
					if (fileName.lastIndexOf("\\") >= 0) 
						file = new File(filePath+ fileName.substring(fileName.lastIndexOf("\\")));
					else 
						file = new File(filePath+ fileName.substring(fileName.lastIndexOf("\\") + 1));
					
					fileItem.write(file);
				}
			}
			
		} 
		catch (Exception ex) 
		{
			System.out.println(ex);
		}
	}
}
