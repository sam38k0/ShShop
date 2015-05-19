package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;
import com.shshop.util.SqlDataUtil;

public class JoinCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String ktalk = request.getParameter("ktalk");
		String birthday = request.getParameter("birthday");
		String bio = request.getParameter("bio"); 
		java.sql.Date birthdaySqlDate = SqlDataUtil.getSqlDate(birthday);
 
		return new AuthenticatorService(request,response)
					.registerUser(new User(email, password, name, phone, ktalk, bio, birthdaySqlDate));
	}
}
