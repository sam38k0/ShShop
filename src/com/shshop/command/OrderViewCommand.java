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
import com.shshop.domain.OrderInfomationList;
import com.shshop.domain.OrderInformation;
import com.shshop.domain.OrderSetting;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.service.OrderService;

public class OrderViewCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute(Constant.attrUser);
		
		OrderService orderService = new OrderService(request, response);
		
		// 구매 리스트
		List<Order> buyOrder = orderService.selectBuyOrder(user.getUserId());
		OrderInfomationList buyOrderInfoList = new OrderInfomationList();
		
		for (Order order : buyOrder) {
			User sellUser = orderService.selectSellInfo(order.getProductId());
			Product product = orderService.selectProduct(order.getProductId());
			Address sellAdd = orderService.selectSellAddress(order.getProductId());
			OrderState buyState = orderService.selectOrderState(order.getOrderId());
			
			buyOrderInfoList.addOrderInformation(sellUser,product,order, buyState,sellAdd);
		}
		
		if(buyOrderInfoList.getOrderInfos().size() > 0 )
			request.setAttribute("buyOrderInfoList", buyOrderInfoList);
		
		
		// 판매 리스트
		List<Order> sellOrder = orderService.selectSellOrder(user.getUserId());
		OrderInfomationList sellOrderInfoList = new OrderInfomationList();
		
		for(Order order: sellOrder) {  
			User buyUser = orderService.selectBuyInfo(order.getUserId());
			Product product =  orderService.selectProduct(order.getProductId());
			Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
			OrderState sellState = orderService.selectOrderState(order.getOrderId());
			
			sellOrderInfoList.addOrderInformation(buyUser, product, order, sellState, buyAdd);
		}
		
		request.setAttribute("sellOrderInfoList", sellOrderInfoList);
		
		CommandResult comResult = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		return comResult;
	}
}
