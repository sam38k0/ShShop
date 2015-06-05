package com.shshop.domain;

import java.io.Serializable;

public class Address implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer idAddress;
	private Integer userId;
	private String basicAdd;
	private String detailAdd;
	
	public Address () {
		
	}
	
	public Address (Integer userId, String basicAdd, String detailAdd) {
		this.userId = userId;
		this.basicAdd = basicAdd;
		this.detailAdd = detailAdd;
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
	
}
