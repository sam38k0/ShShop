package com.shshop.domain;

import java.util.ArrayList;
import java.util.List;

import com.shshop.helper.PageDivider;

public class OrderInfomationList {
	private List<OrderInformation> orderInfos = new ArrayList<>();
	private PageDivider<OrderInformation> pageDivider = null;
	
	public OrderInfomationList(int currentPage, int pageDivNum) {
		this.getOrderInfos();
		this.createPageDivider(currentPage, pageDivNum);
	}
	
	public void addOrderInformation(User user, Product product, ProductImage productImg, Order order, OrderState orderState, Address address) {
		getOrderInfos().add(new OrderInformation(user, product, productImg, order, orderState, address));
	}

	public void addOrderInformation(OrderInformation orderInfo) {
		getOrderInfos().add(orderInfo);
	}

	public List<OrderInformation> getOrderInfos() {
		return orderInfos;
	}

	public void setOrderInfos(List<OrderInformation> orderInfos) {
		this.orderInfos = orderInfos;
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
