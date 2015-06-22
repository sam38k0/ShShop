package com.shshop.domain;

import java.sql.Date;

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
	
	public Integer getOrderId() {
		return order.getOrderId();
	}

	public void setOrderId(Integer orderId) {
		order.setOrderId(orderId);
	}

	public Integer getUserId() {
		return order.getUserId();
	}

	public void setUserId(Integer userId) {
		order.setUserId(userId);
	}

	public Integer getProductId() {
		return order.getProductId();
	}

	public void setProductId(Integer productId) {
		order.setProductId(productId);
	}

	public Integer getIdAddress() {
		return order.getIdAddress();
	}

	public void setIdAddress(Integer idAddress) {
		order.setIdAddress(idAddress);
	}

	public Integer getAmount() {
		return order.getAmount();
	}

	public void setAmount(Integer amount) {
		order.setAmount(amount);
	}

	public Integer getCost() {
		return order.getCost();
	}

	public void setCost(Integer cost) {
		order.setCost(cost);
	}

	public Integer getDeliveryCost() {
		return order.getDeliveryCost();
	}

	public void setDeliveryCost(Integer deliveryCost) {
		order.setDeliveryCost(deliveryCost);
	}

	public String getOrderRequest() {
		return order.getOrderRequest();
	}

	public void setOrderRequest(String orderRequest) {
		order.setOrderRequest(orderRequest);
	}

	public Date getDateCreated() {
		return order.getDateCreated();
	}

	public void setDateCreated(Date dateCreated) {
		order.setDateCreated(dateCreated);
	}

	public Date getDateUpdated() {
		return order.getDateUpdated();
	}

	public void setDateUpdated(Date dateUpdated) {
		order.setDateUpdated(dateUpdated);
	}
}
