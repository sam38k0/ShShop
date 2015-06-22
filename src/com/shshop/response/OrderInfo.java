package com.shshop.response;

import com.shshop.domain.Order;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;

public class OrderInfo { 
	private Product product;
	private Order order;
	private OrderState orderState;
	private String imagePath;
	private int quantity;
	private int shippingPrice;
	
	public OrderInfo(Order order, OrderState orderState, Product product, String imagePath, int quantity, int shippingPrice) {
		this.setOrder(order);
		this.setProduct(product);
		this.setImagePath(imagePath);
		this.setQuantity(quantity);
		this.setShippingPrice(shippingPrice);
		this.setOrderState(orderState);
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
		return getOrder().getAmount();
	}

	public void setQuantity(int quantity) {
		getOrder().setAmount(quantity);
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	public int getPrice() {
		return product.getPrice() * quantity;
	}

	public int getShippingPrice() {
		return shippingPrice;
	}

	public void setShippingPrice(int shippingPrice) {
		this.shippingPrice = shippingPrice;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public OrderState getOrderState() {
		return orderState;
	}

	public void setOrderState(OrderState orderState) {
		this.orderState = orderState;
	}
}
