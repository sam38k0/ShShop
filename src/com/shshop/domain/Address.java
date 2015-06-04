package com.shshop.domain;

import java.io.Serializable;

public class Address implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer idAddress;
	private Integer idUser;
	private String basicAdd;
	private String detailAdd;
	
	public Address () {
		
	}
	
	public Address (Integer idAddress, Integer idUser, String basicAdd, String detailAdd) {
		this.idAddress = idAddress;
		this.idUser = idUser;
		this.basicAdd = basicAdd;
		this.detailAdd = detailAdd;
	}
	
	public Integer getIdAddress() {
		return idAddress;
	}

	public void setIdAddress(Integer idAddress) {
		this.idAddress = idAddress;
	}

	public Integer getIdUser() {
		return idUser;
	}

	public void setIdUser(Integer idUser) {
		this.idUser = idUser;
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
