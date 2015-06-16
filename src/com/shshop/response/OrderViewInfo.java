package com.shshop.response;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Address;
import com.shshop.domain.User;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>();
	private List<Address> addressesOrigin = new ArrayList<>();
	private List<Address> addressesNew = new ArrayList<>();
	private User user;
	private String userPhoneNumberHead = "";
	private String userPhoneNumberMid = "";
	private String userPhoneNumberTail = "";

	public OrderViewInfo(User user, List<Address> addresses) {
		this.setUser(user);
		this.setAddresses(addresses);
	}
	
	public String getUserPhoneNumberHead() {
		return userPhoneNumberHead;
	}
	
	public String getUserPhoneNumberMid() {
		return userPhoneNumberMid;
	}
	
	public String getUserPhoneNumberTail() {
		return userPhoneNumberTail;
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
		String phoneNumber = this.user.getPhone();
		if(phoneNumber == null || phoneNumber == "")
			return;
		
		String[] splitedPhoneNumber = phoneNumber.split("-");
		
		if(splitedPhoneNumber.length != 3)
			return;
		 
		userPhoneNumberHead = splitedPhoneNumber[0];
		userPhoneNumberMid = splitedPhoneNumber[1];
		userPhoneNumberTail = splitedPhoneNumber[2];
	}

	public List<Address> getAddressesOrigin() {
		return addressesOrigin;
	}
	
	public List<Address> getAddressesNew() {
		return addressesNew;
	}
	
	public Address getBasicAddressOrigin() {
		if(addressesOrigin != null) {
			return addressesOrigin.get(0);
		}
		
		return null;
	}
	
	public Address getBasicAddressNew() {
		if(addressesNew != null) {
			return addressesNew.get(0);
		}
		
		return null;
	}
	
	public void setAddresses(List<Address> addresses) {
		
		boolean fliflop = true;
		
		for(Address address: addresses) {
			if(fliflop) {
				addressesOrigin.add(address);
			} else {
				addressesNew.add(address);
			}
			
			fliflop = !fliflop;
		}
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
