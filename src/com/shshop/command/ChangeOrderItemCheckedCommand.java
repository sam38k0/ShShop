package com.shshop.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;

public class ChangeOrderItemCheckedCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strOrderUncheckedIndex = request.getParameter(Constant.attrUncheckedIndx); 
		
		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		
		List<OrderInfo> orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		for(int i = 0; i < orderInfos.size(); i++) {
			if(strOrderUncheckedIndex.contains("" + i))
				orderInfos.get(i).setUnchecked(true);
			else
				orderInfos.get(i).setUnchecked(false);
		} 
		 
		int currentPage = orderViewInfo.getPageDivider().getCurrentPage(); 
		orderViewInfo.setCurrentPageOrderInfos(orderInfos);  
		
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrDataPage, currentPage);
		request.setAttribute(Constant.attrCurrentPagesResult, orderInfos);

		return new CommandResult("/WEB-INF/view/shoppingCartView/cartListJsonData.jsp");
	
	}

}
