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
import com.shshop.service.ProductService;

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

		OrderViewInfo orderViewInfo = new OrderViewInfo(user, addresses, 1, 5);
		ProductService productService = new ProductService();

		for(int i = 0; i < 102; i++) {
			OrderInfo orderInfo = productService.createNewOrderInfo(request, user.getUserId(), i, Format.randBetween(1, 10), Format.randBetween(2500, 5000), "주의", OrderState.VirtualOrder);
			if(orderInfo != null)
				orderViewInfo.addOrderInfo(orderInfo);
		}		
		
		String orderKey = UUID.randomUUID().toString();

		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrOrderKey, orderKey);

		synchronized (session) {
			session.setAttribute(orderKey, orderViewInfo);
		}

		return new CommandResult("/WEB-INF/view/orderView/order.jsp");
	}
}
