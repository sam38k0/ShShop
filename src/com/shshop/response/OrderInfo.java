package com.shshop.response;

import com.shshop.domain.Product;

public class OrderInfo {
	private Product product;
	private int quantity;
	
	public OrderInfo(Product product, int quantity) {
		this.setProduct(product);
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
}
