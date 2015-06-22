package com.shshop.response;

import com.shshop.domain.Address;

public class AddressPair {
	private boolean isDeleted = false;
	private String userName;
	private Address addressOrigin;
	private Address addressNew;

	public AddressPair(Address addressOrigin, Address addressNew) {
		this.addressOrigin = addressOrigin;
		this.addressNew = addressNew;
	}

	public Address getAddressOrigin() {
		return addressOrigin;
	}

	public void setAddressOrigin(Address addressOrigin) {
		this.addressOrigin = addressOrigin;
	}

	public Address getAddressNew() {
		return addressNew;
	}

	public void setAddressNew(Address addressNew) {
		this.addressNew = addressNew;
	}

	public void setBasicAdd(String basicAdd, String basicAddNew) {
		addressOrigin.setBasicAdd(basicAdd);
		addressNew.setBasicAdd(basicAddNew);
	}
	
	public void setDetailAdd(String detailAdd) {
		addressOrigin.setDetailAdd(detailAdd);
		addressNew.setDetailAdd(detailAdd);
	}

	public void setPostNumHeader(String postNumHeader) {
		addressNew.setPostNumHeader(postNumHeader);
		addressOrigin.setPostNumHeader(postNumHeader);
	}

	public void setPostNumTail(String postNumTail) {
		addressNew.setPostNumTail(postNumTail);
		addressOrigin.setPostNumTail(postNumTail);
	}

	public void setName(String name) {
		addressNew.setName(name);
		addressOrigin.setName(name);
	}

	public void setPhoneNumber(String phoneNumber) {
		addressNew.setPhoneNumber(phoneNumber);
		addressOrigin.setPhoneNumber(phoneNumber);
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
}
