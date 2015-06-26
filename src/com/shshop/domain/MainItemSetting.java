package com.shshop.domain;

import java.util.List;

import com.shshop.domain.Product;

public class MainItemSetting {
	private List<MainItemSetting> productList;
	private Product product;
	private String imagePath;
	
	public MainItemSetting(Product product, String imagePath) {
		this.setProduct(product);
		this.setImagePath(imagePath);
	}
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public List<MainItemSetting> getProductList() {
		return productList;
	}

	public void setProductList(List<MainItemSetting> productList) {
		this.productList = productList;
	}
}
