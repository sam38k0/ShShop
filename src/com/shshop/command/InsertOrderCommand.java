package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;

public class InsertOrderCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		CommandResult comm = null;
		HttpSession session = request.getSession(false);
		
		User user = (User) session.getAttribute(Constant.attrUser);
		AuthenticatorService attService = new AuthenticatorService(request, response);
		Address address = attService.getUserAdd(user.getUserId());
		
		
		Integer userId = user.getUserId();
		Integer productId = Integer.parseInt(request.getParameter("productId"));
		Integer addressId = address.getIdAddress();
		
		return null;
	}
	
}
