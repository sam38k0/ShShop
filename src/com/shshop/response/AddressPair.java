package com.shshop.response;

import com.shshop.domain.Address;

public class AddressPair {
	private Address addressOrigin;
	private Address addressNew;

	public AddressPair(Address addressOrigin, Address addressNew) {
		super();
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

	public void setDetailAdd(String detailAddrOld, String detailAddrNew) {
		addressNew.setDetailAdd(detailAddrNew);
		addressOrigin.setDetailAdd(detailAddrOld);
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
}
