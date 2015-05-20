package com.shshop.servlet.test;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/UploadServlet")
public class UploadFileToServerTest extends HttpServlet {

	private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 50 * 1024;
	private int maxMemSize = 10 * 1024;
	private File file; 

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException 
	{
		filePath = request.getServletContext().getInitParameter("file-upload");
		isMultipart = ServletFileUpload.isMultipartContent(request);
		java.io.PrintWriter out = response.getWriter();

		if (!isMultipart)
			return;
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File("c:\\temp"));

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
			out.println("</body>");
			out.println("</html>");
			
		} 
		catch (Exception ex) 
		{
			System.out.println(ex);
		}
	}
}