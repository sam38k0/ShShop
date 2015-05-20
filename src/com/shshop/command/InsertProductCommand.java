package com.shshop.command;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.service.ProductService;

public class InsertProductCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		ProductService service = new ProductService(request,response);
		
		try {
			service.insertProduct();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
