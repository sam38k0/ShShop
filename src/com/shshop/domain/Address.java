package com.shshop.domain;

import java.io.Serializable;

public class Address implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer idAddress;
	private Integer parentIdAddress;
	private Integer userId;
	private String basicAdd;
	private String detailAdd;
	private String postNumHeader;
	private String postNumTail;

	public Address() {

	}

	public Address(Integer userId, Integer parentIdAddress, String basicAdd, String detailAdd, String postNumHeader, String postNumTail) {
		this.userId = userId;
		this.basicAdd = basicAdd;
		this.detailAdd = detailAdd;
		this.parentIdAddress = parentIdAddress;
		this.postNumHeader = postNumHeader;
		this.postNumTail = postNumTail;
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
}
