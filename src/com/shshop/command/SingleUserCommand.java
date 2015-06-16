package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;

public class SingleUserCommand implements Command{
	
	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		CommandResult comm = null;
		HttpSession session = request.getSession(false);
		
		if(session == null)
			return null;
		
		User user = (User) session.getAttribute(Constant.attrUser);
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
		
		request.setAttribute("user", attService.getViewSingleUser(user.getUserId()));
		request.setAttribute("address", attService.getUserAddress(user.getUserId()).get(0));
		
		comm = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		
		return comm;
	}
}