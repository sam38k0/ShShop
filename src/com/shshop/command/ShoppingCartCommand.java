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
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.ProductService;

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

		OrderViewInfo orderViewInfo = new OrderViewInfo(user, addresses);
		ProductService productService = new ProductService();

		orderViewInfo.addOrderInfo(
				productService.createNewOrderInfo(request, user.getUserId(), 1, 3, 2500, "주의", OrderState.VirtualOrder));
		orderViewInfo.addOrderInfo(
				productService.createNewOrderInfo(request, user.getUserId(), 2, 3, 5000, "주의", OrderState.VirtualOrder));
		orderViewInfo.addOrderInfo(
				productService.createNewOrderInfo(request, user.getUserId(), 3, 3, 10000, "주의", OrderState.VirtualOrder));

		String orderKey = UUID.randomUUID().toString();

		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrOrderKey, orderKey);

		synchronized (session) {
			session.setAttribute(orderKey, orderViewInfo);
		}

		return new CommandResult("/WEB-INF/view/shoppingCartView/shoppingCart.jsp");
	}
}
