package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.Product;
import com.shshop.service.AuthenticatorService;

public class MainViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) { 
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
		
		List<Product> productsC = attService.getProductTypeCount();
		
		List<Product> productsD = attService.getProductTypeDate();
		request.setAttribute("productsC", productsC);
		request.setAttribute("productsD", productsD);
		
		 return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}
}