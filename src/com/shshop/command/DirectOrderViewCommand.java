package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;

public class DirectOrderViewCommand  implements Command{
	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		AuthenticatorService authenticatorService = new AuthenticatorService();
		List<Address> addresses = authenticatorService.getUserAddress(user.getUserId());
		if (addresses == null) {
			return new CommandResult(Constant.textPlain, Constant.noAddress);
		}
 
		String directOrderKey = "directOrderKey_" + user. getUserId().toString();
		OrderViewInfo directOrderViewInfo = (OrderViewInfo) session.getAttribute(directOrderKey);
		if(directOrderViewInfo != null) {
			request.setAttribute(Constant.attrOrderViewInfo, directOrderViewInfo);
			request.setAttribute(Constant.attrOrderKey, directOrderKey);
			
			return new CommandResult("/WEB-INF/view/orderView/order.jsp");
		} 
		
		return null;
	}
}
