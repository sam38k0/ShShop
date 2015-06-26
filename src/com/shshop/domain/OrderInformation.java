package com.shshop.domain;

import java.io.Serializable;

public class OrderInformation implements Serializable{
	private static final long serialVersionUID = 1L;
	private User user;
	private Product product;
	private String imagePath;
	private Order order;
	private OrderState orderState;
	private Address address;
	private int totalPrice;

	public OrderInformation(User user, Product product, String imagePath, Order order, OrderState orderState, Address address) {
		this.setUser(user);
		this.setProduct(product);
		this.setImagePath(imagePath);
		this.setOrder(order);
		this.setOrderState(orderState);
		this.setAddress(address);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
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

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	public void setTotalPrice(Order order) {
		this.totalPrice = order.getCost();
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}
}
