package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Product;
import com.shshop.service.AuthenticatorService;
import com.shshop.system.AdminBean;

public class viewMainCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession httpSession = request.getSession();
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
		
		List<Product> productsC = attService.getProductTypeCount();
		
		List<Product> productsD = attService.getProductTypeDate();
		request.setAttribute("productsC", productsC);
		request.setAttribute("productsD", productsD);
		
		 return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}
}