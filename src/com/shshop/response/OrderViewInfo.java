package com.shshop.response;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Address;
import com.shshop.domain.User;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>();
	private User user;
	private List<Address> addresses; 

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

	public String getTotalPrice() {
		int totalPrice = 0;
		for(OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getProductTotalPrice();
			totalPrice += orderInfo.getShippingPrice();
		}
		
	    DecimalFormat df = new DecimalFormat("#,###"); 
		return df.format(totalPrice);
	}
	
	public String getShippingTotalPrice() {
		int totalPrice = 0;
		for(OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getShippingPrice();
		}
		
	    DecimalFormat df = new DecimalFormat("#,###"); 
		return df.format(totalPrice);
	}
	
	public String getProductsTotalPrice() {
		int totalPrice = 0;
		for(OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getProductTotalPrice();
		}
		
	    DecimalFormat df = new DecimalFormat("#,###"); 
		return df.format(totalPrice);
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

	public String getTotalDescription() {
		String totalDescription = "";
		try {
			int totalQuantity = 0;
			for(OrderInfo orderInfo : orderInfos ){
				totalQuantity += orderInfo.getQuantity();
			}
			
			totalDescription = "" + orderInfos.size() + " 종 ( " + totalQuantity + ") 개";
		} catch (Exception e) {
			totalDescription = "";
		}
		
		return totalDescription;
	}
}
