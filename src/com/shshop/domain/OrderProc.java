package com.shshop.domain;

public class OrderProc {
	private Order order;
	private Integer insertedOrderId;
	
	public OrderProc(Order order) {
		this.setOrder(order);
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Integer getInsertedOrderId() {
		return insertedOrderId;
	}

	public void setInsertedOrderId(Integer insertedOrderId) {
		this.insertedOrderId = insertedOrderId;
	}
}
