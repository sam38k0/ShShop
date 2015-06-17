package com.shshop.response;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Address;
import com.shshop.domain.User;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>();
	private List<AddressPair> addressesPair = new ArrayList<>();
	
	private User user;
	private String userPhoneNumberHead = "";
	private String userPhoneNumberMid = "";
	private String userPhoneNumberTail = "";

	public OrderViewInfo(User user, List<Address> addresses) {
		this.setUser(user);
		this.setAddresses(addresses);
	}

	public int getAddressesPairSize() {
		return addressesPair.size();
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
		if (!orderInfo.isOpen())
			return;

		orderInfos.add(orderInfo);
	}

	public List<OrderInfo> getOrderInfos() {
		return orderInfos;
	}

	public void setOrderInfos(List<OrderInfo> orderInfos) {
		this.orderInfos = new ArrayList<>();
		for (OrderInfo orderInfo : orderInfos) {
			if (!orderInfo.isOpen())
				continue;

			this.orderInfos.add(orderInfo);
		}
	}

	public String getTotalPrice() {
		int totalPrice = 0;
		for (OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getProductTotalPrice();
			totalPrice += orderInfo.getShippingPrice();
		}

		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(totalPrice);
	}

	public String getShippingTotalPrice() {
		int totalPrice = 0;
		for (OrderInfo orderInfo : orderInfos) {
			totalPrice += orderInfo.getShippingPrice();
		}

		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(totalPrice);
	}

	public String getProductsTotalPrice() {
		int totalPrice = 0;
		for (OrderInfo orderInfo : orderInfos) {
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
		if (phoneNumber == null || phoneNumber == "")
			return;

		String[] splitedPhoneNumber = phoneNumber.split("-");

		if (splitedPhoneNumber.length != 3)
			return;

		userPhoneNumberHead = splitedPhoneNumber[0];
		userPhoneNumberMid = splitedPhoneNumber[1];
		userPhoneNumberTail = splitedPhoneNumber[2];
	}

	public Address getBasicAddressOrigin() {
		if (getAddressesPair() != null) {
			return getAddressesPair().get(0).getAddressOrigin();
		}

		return null;
	}

	public Address getBasicAddressNew() {
		if (getAddressesPair() != null) {
			return getAddressesPair().get(0).getAddressNew();
		}

		return null;
	}

	public String getPhoneNumberHeadHtml() {

		Address address = getBasicAddressOrigin();
		String phoneNumberHead = address.getPhoneNumberHead();

		String[] arrPhoneHeaders = { 
				"<option value=\"010\">010</option>", 
				"<option value=\"011\">011</option>",
				"<option value=\"016\">016</option>", 
				"<option value=\"017\">017</option>", 
				"<option value=\"018\">018</option>",
				"<option value=\"019\">019</option>" 
				};

		switch (phoneNumberHead) {
			case "011": 
				arrPhoneHeaders[1] = "<option value=\"011\" selected=\"selected\">011</option>";
				break;

			case "016": 
				arrPhoneHeaders[2] = "<option value=\"016\" selected=\"selected\">016</option>";
				break;
			
			case "017": 
				arrPhoneHeaders[3] = "<option value=\"017\" selected=\"selected\">017</option>";
				break;
			
			case "018": 
				arrPhoneHeaders[4] = "<option value=\"018\" selected=\"selected\">018</option>";
				break;
				
			default:
				arrPhoneHeaders[0] = "<option value=\"010\" selected=\"selected\">010</option>";
		}
		
		StringBuilder phoneOptionHtmlBuilder = new StringBuilder();

		for(String phoneHeader : arrPhoneHeaders) {
			phoneOptionHtmlBuilder.append(phoneHeader + "\r\n");
		}
		
		return phoneOptionHtmlBuilder.toString();
	}

	public void setAddresses(List<Address> addresses) {
		for(int i = 0; i<addresses.size(); i+=2) {
			getAddressesPair().add(new AddressPair(addresses.get(i),addresses.get(i+1)));
		}
	}

	public String getTotalDescription() {
		String totalDescription = "";
		try {
			int totalQuantity = 0;
			for (OrderInfo orderInfo : orderInfos) {
				totalQuantity += orderInfo.getQuantity();
			}

			totalDescription = "" + orderInfos.size() + " 종 ( " + totalQuantity + ") 개";
		} catch (Exception e) {
			totalDescription = "";
		}

		return totalDescription;
	}

	public List<AddressPair> getAddressesPair() {
		return addressesPair;
	}
}
