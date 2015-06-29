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
import com.shshop.response.OrderInfo;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;

public class MyPageBuyPagingCommand implements Command {

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

		String myPaidProductsKey = "myPaidProductInfoKey_" + user.getUserId().toString();
		
		MyOrdersInfo myOrdersInfo = (MyOrdersInfo) session.getAttribute(myPaidProductsKey);
		if (myOrdersInfo == null || orderService.getOrderCount(user.getUserId()) != myOrdersInfo.getOrderInfos().size()) {
			List<OrderInformation> orderInfo = new ArrayList<>();
			List<Order> orders = orderService.getOrder(user.getUserId());
			
			if (orders != null) {
				for (Order order : orders) {
					Product product = orderService.selectProduct(order.getProductId());
					User seller = authenticatorService.getUserById(product.getUserId());
					String imagePath = orderService.getOrderImagePath(order);
					Address sellAdd = orderService.selectSellAddress(order.getIdAddress());
					OrderState buyState = orderService.getOrderState(order);
					orderInfo.add(new OrderInformation(seller, product, imagePath, order, buyState, sellAdd)); 
				}
				
				myOrdersInfo = new MyOrdersInfo(orderInfo, 1, 5);
				synchronized (session) {
					session.setAttribute(myPaidProductsKey, myOrdersInfo);
				}
			}
		}

		myOrdersInfo.setCurrentPage(Integer.parseInt(dataPage));

		request.setAttribute(Constant.attrMyOrderInfo, myOrdersInfo);

		return new CommandResult("/WEB-INF/view/mypage/myOrdersJsonData.jsp");
	}

}
