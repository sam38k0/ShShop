package com.shshop.command;

import com.shshop.control.CommandResult;
import com.shshop.service.AuthenticatorService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class InsertProductCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
	
		int userId = Integer.parseInt(request.getParameter("userId"));
		String name = request.getParameter("name");					
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");	
		int stock = Integer.parseInt(request.getParameter("stock"));
		String tag = request.getParameter("tag");					
//		boolean tradeOption = String.valueOf(request.getParameter("tradeOption")) != null;
		
//		Product insertProduct = new Product(userId, name, price, description, stock, tag);
//	
//		System.out.println(insertProduct.getUserId());
//		System.out.println(insertProduct.getName());
//		System.out.println(insertProduct.getPrice());
//		System.out.println(insertProduct.getDescription());
//		System.out.println(insertProduct.getStock());
//		System.out.println(insertProduct.getTag());
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
//		attService.insertProduct(insertProduct);
		
		CommandResult commandResult = new CommandResult("/insertProduct.html");
		
		return commandResult;
	}

}



