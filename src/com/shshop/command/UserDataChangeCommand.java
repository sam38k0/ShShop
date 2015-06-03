package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.service.AuthenticatorService;

public class UserDataChangeCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String ktalkId = request.getParameter("ktalk");
		String birthday = request.getParameter("birthday").replace("-", "");
		String bio = request.getParameter("bio");
		String bankName = request.getParameter("bankName");
		String bankNum = request.getParameter("bankNum");
		java.sql.Date birthdaySqlDate = Format.getSqlDate(birthday);
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
		User user = null;
		
		user = attService.getSelectUserId(email);
		user.setName(name);
		user.setPassword(password);
		user.setPhone(phone);
		user.setKtalkId(ktalkId);
		user.setBirthday(birthdaySqlDate);
		user.setBio(bio);
		user.setBankName(bankName);
		user.setBankNum(bankNum);
		
		attService.userDataUpdate(user);
		
		CommandResult comm = new CommandResult("text/plain;charset=UTF-8","회원정보 수정완료");
		return comm;
	}

}