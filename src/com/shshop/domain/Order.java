package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class Order implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer orderId;
	private Integer userId;
	private Integer productId;
	private Integer idAddress;
	private Integer amount; // 주문 수량
	private Integer cost; // 주문 가격
	private Integer deliveryCost; // 배송가격
	private String orderRequest; // 추가 요청사항
	private Date dateCreated;
	private Date dateUpdated;
	
	public Order() {
		
	}
	
	public Order(Integer orderId, Integer userId, Integer productId, Integer idAddress
			,Integer amount, Integer cost, Integer deliveryCost, String orderRequest) {
		this.orderId = orderId;
		this.userId = userId;
		this.productId = productId;
		this.idAddress = idAddress;
		this.amount = amount;
		this.cost = cost;
		this.deliveryCost = deliveryCost;
		this.orderRequest = orderRequest;
	}
	
	public Order(Integer userId, Integer productId, Integer idAddress) {
		this.userId = userId;
		this.productId = productId;
		this.idAddress = idAddress;
	}
	
	public Order(User user, Product product, Address address) {
		this.setUserId(user.getUserId());
		this.setProductId(product.getProductId());
		this.setIdAddress(address.getIdAddress());
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getIdAddress() {
		return idAddress;
	}

	public void setIdAddress(Integer idAddress) {
		this.idAddress = idAddress;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getCost() {
		return cost;
	}

	public void setCost(Integer cost) {
		this.cost = amount * cost;
	}

	public Integer getDeliveryCost() {
		return deliveryCost;
	}

	public void setDeliveryCost(Integer deliveryCost) {
		this.deliveryCost = deliveryCost;
	}

	public String getOrderRequest() {
		return orderRequest;
	}

	public void setOrderRequest(String orderRequest) {
		this.orderRequest = orderRequest;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Date getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}
}
