package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.MypageByBoardList;
import com.shshop.domain.OrderInfomationList;
import com.shshop.domain.OrderInformation;
import com.shshop.domain.Product;

public class MypageListPagingCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		String buyOrderKey = request.getParameter(Constant.attrBuyOrderKey);
		String sellOrderKey = request.getParameter(Constant.attrSellOrderKey);
		String myBoardKey = request.getParameter(Constant.attrMyBoardKey);
		String dataPageInBuy = request.getParameter(Constant.attrDataPageInBuy);
		String dataPageInSell = request.getParameter(Constant.attrDataPageInSell);
		String dataPageInBoard = request.getParameter(Constant.attrDataPageInBoard);
		
		if (buyOrderKey != null) {
			if (dataPageInBuy == null || dataPageInBuy.equals("")) {
				dataPageInBuy = "1";
			}
			OrderInfomationList buyOrderInfoList = (OrderInfomationList) session.getAttribute(buyOrderKey);
			buyOrderInfoList.setCurrentPage(Integer.parseInt(dataPageInBuy));
			List<OrderInformation> buyerCurrentPageInfos = buyOrderInfoList.getCurrentPageOrderInfos();
			request.setAttribute(Constant.attrBuyOrderInfoList, buyOrderInfoList);
			request.setAttribute(Constant.attrDataPageInBuy, dataPageInBuy);
			request.setAttribute(Constant.attrCurrentPagesResultBuying, buyerCurrentPageInfos);
		}
		
		if (sellOrderKey != null) {
			if (dataPageInSell == null || dataPageInSell.equals("")) {
				dataPageInSell = "1";
			}
			
			OrderInfomationList sellOrderInfoList = (OrderInfomationList) session.getAttribute(sellOrderKey);
			sellOrderInfoList.setCurrentPage(Integer.parseInt(dataPageInSell));
			List<OrderInformation> sellerCurrentPageInfos = sellOrderInfoList.getCurrentPageOrderInfos();
			request.setAttribute(Constant.attrSellOrderInfoList, sellOrderInfoList);
			request.setAttribute(Constant.attrDataPageInSell, dataPageInSell);
			request.setAttribute(Constant.attrCurrentPagesResultSelling, sellerCurrentPageInfos);
		}
		
		if (myBoardKey != null) {
			if (dataPageInBoard == null || dataPageInBoard.equals("")) {
				dataPageInBoard = "1";
			}
			
			MypageByBoardList mypageBoardList = (MypageByBoardList) session.getAttribute(myBoardKey);
			mypageBoardList.setCurrentPage(Integer.parseInt(dataPageInBoard));
			List<Product> myBoardListInfos = mypageBoardList.getCurrentPageOrderInfos();
			request.setAttribute(Constant.attrMyProductsList, mypageBoardList);
			request.setAttribute(Constant.attrDataPageInBoard, dataPageInBoard);
			request.setAttribute(Constant.attrCurrentPagesResultBoard, myBoardListInfos);
		}
		
		return new CommandResult("/WEB-INF/view/mypage/orderListJsonData.jsp");
	}
}
