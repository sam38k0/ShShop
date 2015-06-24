package com.shshop.response;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.helper.PageDivider;

public class OrderViewInfo {
	private List<OrderInfo> orderInfos = new ArrayList<>();
	private List<AddressPair> addressesPair = new ArrayList<>();
	private PageDivider<OrderInfo> pageDivider = null;
	
	private User user;
	private String userPhoneNumberHead = "";
	private String userPhoneNumberMid = "";
	private String userPhoneNumberTail = "";

	public OrderViewInfo(User user, List<Address> addresses, int currentPage, int pageDivNum) {
		this.setUser(user);
		this.setAddresses(addresses);
		this.createPageDivider(currentPage, pageDivNum);
	}

	public int getOrderInfoAvailableSize() {
		int countAvailable = 0;
		
		for(OrderInfo orderInfo : orderInfos) {
			if(orderInfo.isAvailable())
				countAvailable++;
		}
		
		return countAvailable;
	}

	public int getAddressesPairSize() {
		return addressesPair.size();
	}
	
	public int getAddressesPairVaildSize() {
		int count = 0;
		for(AddressPair addrPair : addressesPair) {
			if(!addrPair.isDeleted())
				count++;
		}
		return count;
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
			if(orderInfo.getUnchecked())
				continue;
			
			totalPrice += orderInfo.getProductTotalPrice();
			totalPrice += orderInfo.getShippingPrice();
		}

		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(totalPrice);
	}

	public String getShippingTotalPrice() {
		int totalPrice = 0;
		for (OrderInfo orderInfo : orderInfos) {
			if(orderInfo.getUnchecked())
				continue;
			
			totalPrice += orderInfo.getShippingPrice();
		}

		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(totalPrice);
	}

	public String getProductsTotalPrice() {
		int totalPrice = 0;
		for (OrderInfo orderInfo : orderInfos) {
			if(orderInfo.getUnchecked())
				continue;
			
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

	public void setAddresses(List<Address> addresses) {
		for(int i = 0; i<addresses.size(); i+=2) {
			getAddressesPair().add(new AddressPair(addresses.get(i),addresses.get(i+1)));
		}
	}

	public String getTotalDescription() {
		String totalDescription = "";
		try {
			int totalQuantity = 0;
			int itemCount = 0;
			for (OrderInfo orderInfo : orderInfos) {
				if(orderInfo.getUnchecked())
					continue;
				itemCount ++;
				totalQuantity += orderInfo.getQuantity();
			}

			totalDescription = "" + itemCount + "종(" + totalQuantity + ")개";
		} catch (Exception e) {
			totalDescription = "";
		}

		return totalDescription;
	}

	public List<AddressPair> getAddressesPair() {
		return addressesPair;
	}
	
	public void addAddressPair(AddressPair addressPair) {
		addressesPair.add(addressPair);
	}
	
	public void removeAddressPair(int indx) {
		//Remove Session Data (인덱스 번호를 유지해야 하므로 내부 데이터를 null 로 처리 )
		AddressPair addressPair = addressesPair.get(indx);
		addressPair.setDeleted(true);
	}
	
	public List<OrderInfo> getCurrentPageOrderInfos() {
		return getPageDivider().getCurrentPageData();
	}
	
	public void setCurrentPageOrderInfos(List<OrderInfo> newOrderInfo) {
		int currentPage = getPageDivider().getCurrentPage();
		int pageDivNum = getPageDivider().getPageDivNum();
		
		int startIndex = (currentPage - 1) * pageDivNum;
		
		//Replace Data
		for(int i=0; i< newOrderInfo.size(); i++) {
			OrderInfo orderInfo = orderInfos.get(startIndex + i);
			orderInfo = newOrderInfo.get(i); 
		}
	}
	
	public void setCurrentPage(int currentPage) {
		if(currentPage <= 0)
			currentPage = 1;
		
		getPageDivider().setCurrentPage(currentPage);
	}
	
	private void createPageDivider(int currentPage, int pageDivNum) {
		setPageDivider(new PageDivider<OrderInfo>(currentPage, pageDivNum, orderInfos));
	}

	public PageDivider<OrderInfo> getPageDivider() {
		return pageDivider;
	}

	public void setPageDivider(PageDivider<OrderInfo> pageDivider) {
		this.pageDivider = pageDivider;
	}

	public void removOrderData(int orderIndex) {
		orderInfos.remove(orderIndex);
	}

	public void changeItemQuantity(int index, int itemQuantity) {
		orderInfos.get(index).getOrder().setAmount(itemQuantity);
	}
}