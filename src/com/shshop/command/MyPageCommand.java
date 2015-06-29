package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Order;
import com.shshop.domain.OrderState;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;
import com.shshop.service.ProductService;

public class MyPageCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		OrderService orderService = new OrderService();
		ProductService productService = new ProductService();
		AuthenticatorService authenticatorService = new AuthenticatorService();

		int productTotalCount = productService.getProductsCountOfUser(user.getUserId());
		int proudctHasStockCount = productService.getHasStockProductCountOfUser(user.getUserId());
		int proudctNoStockCount= productTotalCount - proudctHasStockCount;
		int totalOrderCount = 0;
		int sendedEmailOrderCount = 0;
		
		List<Order> orders = orderService.getOrder(user.getUserId());
		if (orders != null) {
			totalOrderCount = orders.size();
			
			for (Order order : orders) {
				OrderState orderState = orderService.getOrderState(order);
				if(orderState.getSendedEmail()) {
					sendedEmailOrderCount++;
				}
			}
		}
		
		int sellOrderDeliveredCount = 0;
		int sellOrderNotDeliveredCount = 0;
		int sellOrderTotalCount = orderService.getSellOrderCount(user.getUserId());
		List<Order> sellOrder = orderService.getSellOrder(user.getUserId());
		if(sellOrder != null) {
			for (Order order : sellOrder) {
				OrderState orderState = orderService.getOrderState(order);
				if(orderState.getDelivered() == true) {
					sellOrderDeliveredCount++;
				} else {
					sellOrderNotDeliveredCount++;
				}
			}
		}
		
		// 개인 정보
		request.setAttribute(Constant.attrMyProudctsItemCount, productTotalCount);
		request.setAttribute(Constant.attrMyProudctsItemCountHasStock, proudctHasStockCount);
		request.setAttribute(Constant.attrMyProudctsItemCountNoStock, proudctNoStockCount);
		request.setAttribute(Constant.attrTotalOrderCount, totalOrderCount);
		request.setAttribute(Constant.attrSendedEmailOrderCount, sendedEmailOrderCount);
		request.setAttribute(Constant.attrSellOrderTotalCount, sellOrderTotalCount);
		request.setAttribute(Constant.attrSellOrderDeliveredCount, sellOrderDeliveredCount);
		request.setAttribute(Constant.attrSellOrderNotDeliveredCount, sellOrderNotDeliveredCount);
		request.setAttribute("user", authenticatorService.getViewSingleUser(user.getUserId()));
		request.setAttribute("address", authenticatorService.getUserAddress(user.getUserId()).get(0));
		
		CommandResult comResult = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		return comResult;
	}
}
