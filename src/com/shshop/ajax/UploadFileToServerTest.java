package com.shshop.ajax;

import java.io.File;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/UploadServlet")
public class UploadFileToServerTest extends HttpServlet {

	private boolean isMultipart;
	private String filePath;
	private int maxFileSize = 50 * 1024;
	private int maxMemSize = 10 * 1024;
	private File file;

//	public void init() 
//	{
//		filePath = getServletContext().getInitParameter("file-upload");
//	}
//
//	public void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, java.io.IOException 
//	{
//		isMultipart = ServletFileUpload.isMultipartContent(request);
//		java.io.PrintWriter out = response.getWriter();
//
//		if (!isMultipart)
//			return;
//		
//		DiskFileItemFactory factory = new DiskFileItemFactory();
//		factory.setSizeThreshold(maxMemSize);
//		factory.setRepository(new File("c:\\temp"));
//
//		ServletFileUpload upload = new ServletFileUpload(factory);
//		upload.setSizeMax(maxFileSize);
//
//		try 
//		{
//			List<FileItem> fileItems = upload.parseRequest(request);
//
//			Iterator<FileItem> i = fileItems.iterator();
//
//			while (i.hasNext()) 
//			{
//				FileItem fileItem = (FileItem) i.next();
//				if (!fileItem.isFormField()) 
//				{
//					String fileName = fileItem.getName();
//					
//					if (fileName.lastIndexOf("\\") >= 0) 
//						file = new File(filePath+ fileName.substring(fileName.lastIndexOf("\\")));
//					else 
//						file = new File(filePath+ fileName.substring(fileName.lastIndexOf("\\") + 1));
//					
//					fileItem.write(file);
//				}
//			}
//			out.println("</body>");
//			out.println("</html>");
//			
//		} 
//		catch (Exception ex) 
//		{
//			System.out.println(ex);
//		}
//	}
}