package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderInfomationList;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.ProductImage;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;
import com.shshop.service.ProductService;

public class OrderStateCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute(Constant.attrUser);

		OrderService orderService = new OrderService();
		ProductService productService = new ProductService();
		AuthenticatorService authenticatorService = new AuthenticatorService();
		
		
		// 판매자 정보
		List<Order> buyOrder = orderService.selectBuyOrder(user.getUserId());
		if (buyOrder != null && buyOrder.size() > 0) {
			OrderInfomationList buyOrderInfoList = new OrderInfomationList();

			for (Order order : buyOrder) {
				Product product = orderService.selectProduct(order.getProductId());
				User sellUser = authenticatorService.getUserById(product.getUserId());
				ProductImage productImg = productService.getProductImg(order.getProductId());
				Address sellAdd = orderService.selectSellAddress(order.getIdAddress());
				OrderState buyState = orderService.selectOrderState(order.getOrderId());

				buyOrderInfoList.addOrderInformation(sellUser, product, productImg, order, buyState, sellAdd);
			}

			if (buyOrderInfoList.getOrderInfos().size() > 0)
				request.setAttribute("buyOrderInfoList", buyOrderInfoList);
		}

		// 구매자 정보
		List<Order> sellOrder = orderService.selectSellOrder(user.getUserId());


		if (sellOrder != null && sellOrder.size() > 0) {
			OrderInfomationList sellOrderInfoList = new OrderInfomationList();

			for (Order order : sellOrder) {
				
				User buyer = authenticatorService.getUserById(order.getUserId());
				Product product = orderService.selectProduct(order.getProductId());
				ProductImage productImg = productService.getProductImg(order.getProductId());
				Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
				OrderState sellState = orderService.selectOrderState(order.getOrderId());

				sellOrderInfoList.addOrderInformation(buyer, product, productImg, order, sellState, buyAdd);
			}

			if (sellOrderInfoList.getOrderInfos().size() > 0)
				request.setAttribute("sellOrderInfoList", sellOrderInfoList);
		}

		CommandResult comResult = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		return comResult;
	}
}
