package com.shshop.response;

import java.util.ArrayList;
import java.util.List;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>(); 
    private int totalPrice;

	public OrderViewInfo() {
		
	}
	
	public void addOrderInfo(OrderInfo orderInfo) {
		if(!orderInfo.isOpen())
			return;
		
		orderInfos.add(orderInfo);
	}

	public List<OrderInfo> getOrderInfos() {
		return orderInfos;
	}

	public void setOrderInfos(List<OrderInfo> orderInfos) {
		this.orderInfos = new ArrayList<>();
		for(OrderInfo orderInfo : orderInfos) {
			if(!orderInfo.isOpen())
				continue;
			
			this.orderInfos.add(orderInfo);
		}
	}

	public int getTotalPrice() {
		totalPrice = 0;
		for(OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getProductTotalPrice();
		}
		
		return totalPrice;
	}
}
