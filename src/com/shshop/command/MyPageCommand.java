package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.MypageByBoardList;
import com.shshop.domain.Order;
import com.shshop.domain.OrderInfomationList;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.ProductImage;
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

		// 판매자 정보
		List<Order> buyOrder = orderService.getOrder(user.getUserId());
		if (buyOrder != null && buyOrder.size() > 0) {
			OrderInfomationList buyOrderInfoList = new OrderInfomationList(1,5);
			
			for (Order order : buyOrder) {
				Product product = orderService.selectProduct(order.getProductId());
				User seller = authenticatorService.getUserById(product.getUserId());
				String imagePath = orderService.getOrderImagePath(order);
				Address sellAdd = orderService.selectSellAddress(order.getIdAddress());
				OrderState buyState = orderService.getOrderState(order);

				buyOrderInfoList.addOrderInformation(seller, product, imagePath, order, buyState, sellAdd);
			}
			
			if (buyOrderInfoList.getOrderInfos().size() > 0){
				String buyOrderKey = "buyOrderKey_" + user.getUserId().toString();
				request.setAttribute(Constant.attrBuyOrderInfoList, buyOrderInfoList);
				request.setAttribute(Constant.attrBuyOrderKey, buyOrderKey);
				
				synchronized (session) {
					session.setAttribute(buyOrderKey, buyOrderInfoList);
				}
			}
		}

		// 구매자 정보
		List<Order> sellOrder = orderService.selectSellOrder(user.getUserId());
		if (sellOrder != null && sellOrder.size() > 0) {
			OrderInfomationList sellOrderInfoList = new OrderInfomationList(1,5);

			for (Order order : sellOrder) {

				User buyer = authenticatorService.getUserById(order.getUserId());
				Product product = orderService.selectProduct(order.getProductId());
				String imagePath = orderService.getOrderImagePath(order);
				Address buyAdd = orderService.selectBuyAddress(order.getOrderId());
				OrderState sellState = orderService.getOrderState(order);

				sellOrderInfoList.addOrderInformation(buyer, product, imagePath, order, sellState, buyAdd);
			}

			if (sellOrderInfoList.getOrderInfos().size() > 0){
				String sellOrderKey = "sellOrderKey_" + user.getUserId().toString();
				request.setAttribute(Constant.attrSellOrderInfoList, sellOrderInfoList);
				request.setAttribute(Constant.attrSellOrderKey, sellOrderKey);
				
				synchronized (session) {
					session.setAttribute(sellOrderKey, sellOrderInfoList);
				}
			}
		}
		
		// 판매 등록 게시물 리스트
		List<Product> myProductsList = productService.getProductsById(user.getUserId());
		if (myProductsList != null && myProductsList.size() > 0) {
			MypageByBoardList boardInfo = new MypageByBoardList(myProductsList, 1, 10);
			
			if (boardInfo.getProducts().size() > 0) {
				String myBoardKey = "myBoardKey_" + user.getUserId().toString();
				request.setAttribute(Constant.attrMyProductsList, boardInfo);
				request.setAttribute(Constant.attrMyBoardKey, myBoardKey);
				
				synchronized (session) {
					session.setAttribute(myBoardKey, boardInfo);
				}
			}
		}
		
		// 개인 정보
		request.setAttribute("user", authenticatorService.getViewSingleUser(user.getUserId()));
		request.setAttribute("address", authenticatorService.getUserAddress(user.getUserId()).get(0));
		
		CommandResult comResult = new CommandResult("/WEB-INF/view/mypage/mypage.jsp");
		return comResult;
	}
}
