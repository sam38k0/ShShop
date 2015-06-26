package com.shshop.domain;

import java.io.Serializable;

public class MypageByBoardInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	private Product product;
	private String imagePath;
	

	public MypageByBoardInfo(Product product) {
		this.setProduct(product);
	}
	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
}
