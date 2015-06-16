package com.shshop.domain;

public class AddressProc {
	private Address address;
	private Integer insertedAddressId = -1;

	public AddressProc(Address address) {
		this.address = address;
	}

	public Integer getIdAddress() {
		return address.getIdAddress();
	}

	public void setIdAddress(Integer idAddress) {
		address.setIdAddress(idAddress);
	}

	public Integer getUserId() {
		return address.getUserId();
	}

	public void setUserId(Integer userId) {
		address.setUserId(userId);
	}

	public String getBasicAdd() {
		return address.getBasicAdd();
	}

	public void setBasicAdd(String basicAdd) {
		address.setBasicAdd(basicAdd);
	}

	public String getDetailAdd() {
		return address.getDetailAdd();
	}

	public void setDetailAdd(String detailAdd) {
		address.setDetailAdd(detailAdd);
	}

	public String getPostNumHeader() {
		return address.getPostNumHeader();
	}

	public void setPostNumHeader(String postNumHeader) {
		address.setPostNumHeader(postNumHeader);
	}

	public String getPostNumTail() {
		return address.getPostNumTail();
	}

	public void setPostNumTail(String postNumTail) {
		address.setPostNumTail(postNumTail);
	}

	public Integer getParentIdAddress() {
		return address.getParentIdAddress();
	}

	public void setParentIdAddress(Integer parentIdAddress) {
		address.setParentIdAddress(parentIdAddress);
	}

	public String getName() {
		return address.getName();
	}

	public void setName(String name) {
		address.setName(name);
	}

	public Integer getInsertedAddressId() {
		return insertedAddressId;
	}

	public void setInsertedAddressId(Integer insertedAddressId) {
		this.insertedAddressId = insertedAddressId;
	}

	public String getPhoneNumber() {
		return address.getPhoneNumber();
	}

	public void setPhoneNumber(String phoneNumber) {
		address.setPhoneNumber(phoneNumber);
	}

	public String getPhoneNumberHead() {
		return address.getPhoneNumberHead();
	}

	public void setPhoneNumberHead(String phoneNumberHead) {
		address.setPhoneNumberHead(phoneNumberHead);
	}

	public String getPhoneNumberMid() {
		return address.getPhoneNumberMid();
	}

	public void setPhoneNumberMid(String phoneNumberMid) {
		address.setPhoneNumberMid(phoneNumberMid);
	}

	public String getPhoneNumberTail() {
		return address.getPhoneNumberTail();
	}

	public void setPhoneNumberTail(String phoneNumberTail) {
		address.setPhoneNumberTail(phoneNumberTail);
	}
}
