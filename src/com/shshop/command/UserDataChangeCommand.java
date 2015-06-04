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
		String bagicAdd = request.getParameter("bagicAdd");
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
		
		Address address = new Address();
		
		if (attService.getUserAdd(user.getUserId()) == null) {
			address.setIdUser(user.getUserId());
			address.setBasicAdd(bagicAdd);
			address.setDetailAdd(detailAdd);
			attService.insertUserAdd(address);
			System.out.println("인서트 됨");
		} else {
			address.setBasicAdd(bagicAdd);
			address.setDetailAdd(detailAdd);
			attService.updateUserAdd(address);
			System.out.println("업데이트 됨");
		}
		
		CommandResult comm = new CommandResult("text/plain;charset=UTF-8","회원정보 수정완료");
		return comm;
	}

}