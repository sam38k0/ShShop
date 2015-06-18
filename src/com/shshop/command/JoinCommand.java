package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.service.AuthenticatorService;

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
		java.sql.Date birthdaySqlDate = Format.getSqlDate(birthday);

		return new AuthenticatorService().registerUser(new User(email, password, name, phone, ktalk, bio, birthdaySqlDate));
	}
}
