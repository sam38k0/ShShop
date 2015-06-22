package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;

public class ShoppingCartPageCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		orderViewInfo.setCurrentPage(Integer.parseInt(dataPage));

		List<OrderInfo> orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrDataPage, dataPage);
		request.setAttribute(Constant.attrCurrentPagesResult, orderInfos);

		return new CommandResult("/WEB-INF/view/shoppingCartView/cartListJsonData.jsp");
	}
}
