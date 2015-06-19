package com.shshop.domain;

import java.util.ArrayList;
import java.util.List;

public class OrderInfomationList {
	private List<OrderInformation> orderInfos = new ArrayList<>();

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
}
