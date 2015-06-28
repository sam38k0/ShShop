package com.shshop.command;

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


//		// 구매자 정보
//		List<Order> sellOrder = orderService.selectSellOrder(user.getUserId());
//		if (sellOrder != null && sellOrder.size() > 0) {
//			OrderInfomationList sellOrderInfoList = new OrderInfomationList(1,5);
//
//			for (Order order : sellOrder) {
//
//				User buyer = authenticatorService.getUserById(order.getUserId());
//				Product product = orderService.selectProduct(order.getProductId());
//				String imagePath = orderService.getOrderImagePath(order);
//				Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
//				OrderState sellState = orderService.getOrderState(order);
//
//				sellOrderInfoList.addOrderInformation(buyer, product, imagePath, order, sellState, buyAdd);
//			}
//
//			if (sellOrderInfoList.getOrderInfos().size() > 0){
//				String sellOrderKey = "sellOrderKey_" + user.getUserId().toString();
//				request.setAttribute(Constant.attrSellOrderInfoList, sellOrderInfoList);
//				request.setAttribute(Constant.attrSellOrderKey, sellOrderKey);
//				
//				synchronized (session) {
//					session.setAttribute(sellOrderKey, sellOrderInfoList);
//				}
//			}
//		}
		
		

 
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
		
		// 개인 정보
		request.setAttribute(Constant.attrMyProudctsItemCount, productTotalCount);
		request.setAttribute(Constant.attrMyProudctsItemCountHasStock, proudctHasStockCount);
		request.setAttribute(Constant.attrMyProudctsItemCountNoStock, proudctNoStockCount);
		request.setAttribute(Constant.attrTotalOrderCount, totalOrderCount);
		request.setAttribute(Constant.attrSendedEmailOrderCount, sendedEmailOrderCount);
		request.setAttribute("user", authenticatorService.getViewSingleUser(user.getUserId()));
		request.setAttribute("address", authenticatorService.getUserAddress(user.getUserId()).get(0));
		
		CommandResult comResult = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		return comResult;
	}
}
