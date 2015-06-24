package com.shshop.command;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.OrderState;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;

public class OrderCommand implements Command {

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

		String orderKey = request.getParameter(Constant.attrOrderKey); 
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
 
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrOrderKey, orderKey);

		synchronized (session) {
			session.setAttribute(orderKey, orderViewInfo);
		}

		return new CommandResult("/WEB-INF/view/orderView/order.jsp");
	}
}
