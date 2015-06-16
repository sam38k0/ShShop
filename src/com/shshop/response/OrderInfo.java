package com.shshop.response;

import com.shshop.domain.Product;

public class OrderInfo {
	private Product product;
	private String imagePath;
	private int quantity;
	
	public OrderInfo(Product product, String imagePath, int quantity) {
		this.setProduct(product);
		this.setImagePath(imagePath);
		this.setQuantity(quantity);
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public boolean isOpen(){
		return this.product.isOnOpen();
	}
	
	public int getProductTotalPrice(){
		return getProduct().getPrice() * getQuantity();
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
}
