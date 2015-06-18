package com.shshop.domain;

import java.io.Serializable;

public class Address implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer idAddress;
	private Integer parentIdAddress;
	private Integer userId;
	private String name;
	private String basicAdd;
	private String detailAdd;
	private String postNumHeader;
	private String postNumTail;
	private String phoneNumber;
	private String phoneNumberHead;
	private String phoneNumberMid;
	private String phoneNumberTail;

	public Address() {

	}

	public Address(Integer userId, Integer parentIdAddress, String basicAdd, String detailAdd, String postNumHeader, String postNumTail, String name, String phoneNumber) {
		this.setUserId(userId);
		this.setBasicAdd(basicAdd);
		this.setDetailAdd(detailAdd);
		this.setParentIdAddress(parentIdAddress);
		this.setPostNumHeader(postNumHeader);
		this.setPostNumTail(postNumTail);
		this.setName(name);
		this.setPhoneNumber(phoneNumber);
	}

	public Integer getIdAddress() {
		return idAddress;
	}

	public void setIdAddress(Integer idAddress) {
		this.idAddress = idAddress;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getBasicAdd() {
		return basicAdd;
	}

	public void setBasicAdd(String basicAdd) {
		this.basicAdd = basicAdd;
	}

	public String getDetailAdd() {
		return detailAdd;
	}

	public void setDetailAdd(String detailAdd) {
		this.detailAdd = detailAdd;
	}

	public String getPostNumHeader() {
		return postNumHeader;
	}

	public void setPostNumHeader(String postNumHeader) {
		this.postNumHeader = postNumHeader;
	}

	public String getPostNumTail() {
		return postNumTail;
	}

	public void setPostNumTail(String postNumTail) {
		this.postNumTail = postNumTail;
	}

	public Integer getParentIdAddress() {
		return parentIdAddress;
	}

	public void setParentIdAddress(Integer parentIdAddress) {
		this.parentIdAddress = parentIdAddress;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
		
		String[] splitedPhoneNumber = phoneNumber.split("-");
		
		if(splitedPhoneNumber.length != 3)
			return;
		 
		setPhoneNumberHead(splitedPhoneNumber[0]);
		setPhoneNumberMid(splitedPhoneNumber[1]);
		setPhoneNumberTail(splitedPhoneNumber[2]);
	}

	public String getPhoneNumberHead() {
		return phoneNumberHead;
	}

	public void setPhoneNumberHead(String phoneNumberHead) {
		this.phoneNumberHead = phoneNumberHead;
	}

	public String getPhoneNumberMid() {
		return phoneNumberMid;
	}

	public void setPhoneNumberMid(String phoneNumberMid) {
		this.phoneNumberMid = phoneNumberMid;
	}

	public String getPhoneNumberTail() {
		return phoneNumberTail;
	}

	public void setPhoneNumberTail(String phoneNumberTail) {
		this.phoneNumberTail = phoneNumberTail;
	}
	
	public String getFullAddress() {
		return basicAdd + " " + detailAdd;
	}
	
	public String getPhoneNumberHeadHtml() {
 
		String phoneNumberHead = getPhoneNumberHead();

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
}
