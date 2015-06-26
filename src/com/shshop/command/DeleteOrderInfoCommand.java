package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;

public class DeleteOrderInfoCommand implements Command {

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

		OrderService orderService = new OrderService();
	
		//직구
		String directOrderKey = "directOrderKey_" + user.getUserId().toString();
		OrderViewInfo directorderViewInfo = (OrderViewInfo) session.getAttribute(directOrderKey);
		if (directorderViewInfo != null) {
			List<OrderInfo> orderInfos =  directorderViewInfo.getOrderInfos();
			for(OrderInfo orderInfo: orderInfos) {
				orderService.updateCompletedOrder(orderInfo.getOrder());
			}
			
			synchronized (session) {
				session.setAttribute(directOrderKey, null);
			}
			return new CommandResult("text/html", "Success");
		}

		//장바구니
		String orderKey = "orderKey_" + user.getUserId().toString();

		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		if (orderViewInfo != null) {
			List<OrderInfo> orderInfos =  orderViewInfo.getOrderInfos();
			for(OrderInfo orderInfo: orderInfos) {
				orderService.updateCompletedOrder(orderInfo.getOrder());
			}
			
			synchronized (session) {
				session.setAttribute(orderKey, null);
			}
		}

		return new CommandResult("text/html", "Success");
	}
}
