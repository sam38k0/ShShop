package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;

public class ShoppingCartCommand implements Command {

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
		
		OrderViewInfo orderViewInfo = new OrderViewInfo(user, addresses, 1, 5);
		List<Order> virtualOrders = orderService.getVirtualOrder(user.getUserId());

		for(Order order: virtualOrders ) {
			OrderState orderState = orderService.getOrderState(order);
			Product product = orderService.getOrderProduct(order);
			String imagePath = orderService.getOrderImagePath(order);
			
			OrderInfo orderInfo = new OrderInfo(order, orderState, product, imagePath, order.getAmount(), Format.randBetween(2500, 5000));
 
			if(orderInfo != null)
				orderViewInfo.addOrderInfo(orderInfo);
		}
		
		String orderKey = "orderKey_" + user.getUserId().toString();
		
		request.setAttribute(Constant.attrVirtualOrderCount, orderViewInfo.getOrderInfos().size());
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrOrderKey, orderKey);

		synchronized (session) {
			session.setAttribute(orderKey, orderViewInfo);
		}

		return new CommandResult("/WEB-INF/view/shoppingCartView/shoppingCart.jsp");
	}
}
