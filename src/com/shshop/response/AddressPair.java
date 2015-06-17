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
}
