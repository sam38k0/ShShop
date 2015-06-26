package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.OrderInfomationList;
import com.shshop.domain.OrderInformation;

public class MypageListPagingCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		String buyOrderKey = request.getParameter(Constant.attrBuyOrderKey);
		String sellOrderKey = request.getParameter(Constant.attrSellOrderKey);
		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}
		
		OrderInfomationList buyOrderInfoList = (OrderInfomationList) session.getAttribute(buyOrderKey);
		OrderInfomationList sellOrderInfoList = (OrderInfomationList) session.getAttribute(sellOrderKey);
		buyOrderInfoList.setCurrentPage(Integer.parseInt(dataPage));
		
		List<OrderInformation> buyerCurrentPageInfos = buyOrderInfoList.getCurrentPageOrderInfos();
		List<OrderInformation> sellerCurrentPageInfos = sellOrderInfoList.getCurrentPageOrderInfos();
		
		request.setAttribute(Constant.attrBuyOrderInfoList, buyOrderInfoList);
		request.setAttribute(Constant.attrSellOrderInfoList, sellOrderInfoList);
		request.setAttribute(Constant.attrDataPage, dataPage);
		request.setAttribute(Constant.attrCurrentPagesResultBuying, buyerCurrentPageInfos);
		request.setAttribute(Constant.attrCurrentPagesResultSelling, sellerCurrentPageInfos);
		
		return new CommandResult("/WEB-INF/view/mypage/orderListJsonData.jsp");
	}
}
