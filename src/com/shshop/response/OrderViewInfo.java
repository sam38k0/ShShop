package com.shshop.response;

import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Address;
import com.shshop.domain.User;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>();
	private User user;
	private List<Address> addresses;
    private int totalPrice;

	public OrderViewInfo(User user, List<Address> addresses) {
		this.setUser(user);
		this.setAddresses(addresses);
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}
}
