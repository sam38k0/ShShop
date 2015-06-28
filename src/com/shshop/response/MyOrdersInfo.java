package com.shshop.response;

import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.OrderInformation;
import com.shshop.helper.PageDivider;

public class MyOrdersInfo {
	private List<OrderInformation> orderInfos = new ArrayList<>();
	private PageDivider<OrderInformation> pageDivider = null;

	public MyOrdersInfo(List<OrderInformation> orderInfos, int currentPage, int pageDivNum) {
		this.setOrderInfos(orderInfos, currentPage, pageDivNum);
	}

	public List<OrderInformation> getOrderInfos() {
		return orderInfos;
	}

	public void setOrderInfos(List<OrderInformation> orderInfos, int currentPage, int pageDivNum) {
		this.orderInfos = orderInfos;
		this.createPageDivider(currentPage, pageDivNum);
	}

	public List<OrderInformation> getCurrentPageOrderInfos() {
		return getPageDivider().getCurrentPageData();
	}

	public void setCurrentPageOrderInfos(List<OrderInformation> newOrderInfo) {
		int currentPage = getPageDivider().getCurrentPage();
		int pageDivNum = getPageDivider().getPageDivNum();

		int startIndex = (currentPage - 1) * pageDivNum;

		// Replace Data
		for (int i = 0; i < newOrderInfo.size(); i++) {
			OrderInformation orderInfo = orderInfos.get(startIndex + i);
			orderInfo = newOrderInfo.get(i);
		}
	}

	public void setCurrentPage(int currentPage) {
		if (currentPage <= 0)
			currentPage = 1;

		getPageDivider().setCurrentPage(currentPage);
	}

	private void createPageDivider(int currentPage, int pageDivNum) {
		setPageDivider(new PageDivider<OrderInformation>(currentPage, pageDivNum, orderInfos));
	}

	public PageDivider<OrderInformation> getPageDivider() {
		return pageDivider;
	}

	public void setPageDivider(PageDivider<OrderInformation> pageDivider) {
		this.pageDivider = pageDivider;
	}
}
