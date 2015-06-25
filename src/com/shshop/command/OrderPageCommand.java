package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;

public class OrderPageCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}
		
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
 
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		OrderViewInfo orderViewInfoWithoutUnckeked =  new OrderViewInfo(user, addresses, 1, 5);
		for(OrderInfo orderInfo: orderViewInfo.getOrderInfos()) {
			if(!orderInfo.getUnchecked())
				orderViewInfoWithoutUnckeked.addOrderInfo(orderInfo);
		}
		
		orderViewInfoWithoutUnckeked.setCurrentPage(Integer.parseInt(dataPage));

		List<OrderInfo> orderInfos = orderViewInfoWithoutUnckeked.getCurrentPageOrderInfos();
		
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfoWithoutUnckeked);
		request.setAttribute(Constant.attrDataPage, dataPage);
		request.setAttribute(Constant.attrCurrentPagesResult, orderInfos);

		return new CommandResult("/WEB-INF/view/shoppingCartView/cartListJsonData.jsp");
	}
}
