package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
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
		String basicAdd = request.getParameter("basicAdd");
		String detailAdd = request.getParameter("detailAdd");
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
		
		System.out.println(basicAdd);
		System.out.println(detailAdd);
		Address address = attService.getUserAddress(user.getUserId()).get(0);
		
		if (address == null) {
			address = new Address(user.getUserId(), null, basicAdd, detailAdd,"000","1111", user.getName(), user.getPhone());
			attService.insertUserAddress(address);
		} else {
			address.setBasicAdd(basicAdd);
			address.setDetailAdd(detailAdd);
			attService.updateUserAddress(address);
		}
		
		CommandResult comm = new CommandResult("text/plain;charset=UTF-8","회원정보 수정완료");
		return comm;
	}

}