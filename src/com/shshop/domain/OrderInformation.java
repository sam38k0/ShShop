package com.shshop.domain;

public class OrderInformation {
	private User user;
	private Product product;
	private Order order;
	private OrderState orderState;
	private Address address;
	
	public OrderInformation(User user, Product product, Order order, OrderState orderState, Address address) {
		this.setUser(user);
		this.setProduct(product);
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
}
