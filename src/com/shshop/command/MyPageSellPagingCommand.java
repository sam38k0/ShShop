package com.shshop.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderInformation;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.response.MyOrdersInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;

public class MyPageSellPagingCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		String pageFilter = request.getParameter(Constant.attrDataPageFilter);
		if (pageFilter == null || pageFilter.equals("")) {
			pageFilter = "0";
		}
		 
		AuthenticatorService authenticatorService = new AuthenticatorService();
		OrderService orderService = new OrderService();

		String mySellingProductsKey = "mySellingProductInfoKey_" + user.getUserId().toString();
		
		MyOrdersInfo myOrdersInfo = (MyOrdersInfo) session.getAttribute(mySellingProductsKey);
		if(myOrdersInfo == null || orderService.getSellOrderCount(user.getUserId()) != myOrdersInfo.getOrderInfos().size()) {
			List<Order> sellOrder = orderService.getSellOrder(user.getUserId());
			List<OrderInformation> orderInfo = new ArrayList<>();
			
			if(sellOrder != null) {
				for (Order order : sellOrder) {

					User buyer = authenticatorService.getUserById(order.getUserId());
					Product product = orderService.selectProduct(order.getProductId());
					String imagePath = orderService.getOrderImagePath(order);
					Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
					OrderState sellState = orderService.getOrderState(order);
					orderInfo.add(new OrderInformation(buyer, product, imagePath, order, sellState, buyAdd)); 
				}
				
				myOrdersInfo = new MyOrdersInfo(orderInfo, 1, 5);
				synchronized (session) {
					session.setAttribute(mySellingProductsKey, myOrdersInfo);
				}
			}
		}
		
		// Filtering
		List<OrderInformation> filteredOrder = new ArrayList<>();
		if (pageFilter.equals("1")) {
			List<Order> orders = orderService.getSellOrder(user.getUserId());
			for (Order order : orders) {
				OrderState orderState = orderService.getOrderState(order);
				if(!orderState.getDelivered()) {
					User buyer = authenticatorService.getUserById(order.getUserId());
					Product product = orderService.selectProduct(order.getProductId());
					String imagePath = orderService.getOrderImagePath(order);
					Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
					OrderState sellState = orderService.getOrderState(order);
					filteredOrder.add(new OrderInformation(buyer, product, imagePath, order, sellState, buyAdd));
				}
			}
			myOrdersInfo.setOrderInfos(filteredOrder, 1, 5);

		} else if (pageFilter.equals("2")) {
			List<Order> orders = orderService.getSellOrder(user.getUserId());
			for (Order order : orders) {
				OrderState orderState = orderService.getOrderState(order);
				if(orderState.getDelivered()) {
					User buyer = authenticatorService.getUserById(order.getUserId());
					Product product = orderService.selectProduct(order.getProductId());
					String imagePath = orderService.getOrderImagePath(order);
					Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
					OrderState sellState = orderService.getOrderState(order);
					filteredOrder.add(new OrderInformation(buyer, product, imagePath, order, sellState, buyAdd));
				}
			}
			myOrdersInfo.setOrderInfos(filteredOrder, 1, 5);
		}

		myOrdersInfo.setCurrentPage(Integer.parseInt(dataPage));
		
		request.setAttribute(Constant.attrMyOrderInfo, myOrdersInfo);

		return new CommandResult("/WEB-INF/view/mypage/myOrdersJsonData.jsp");
	}

}
