package com.shshop.domain;

import java.io.Serializable;

public class OrderState implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public static final String VirtualOrder = "virtualOrder";
	public static final String Activated = "activated";
	public static final String Paid = "paid";
	public static final String SendedEmail = "sendedEmail";
	public static final String Shipped = "shipped";
	public static final String Delivered = "delivered";
	public static final String Deleted = "Deleted";

	private Integer orderId;
	private Boolean virtualOrder = false; // 가상주문(장바구니 상태)
	private Boolean activated = false; // 주문 활성화 여부
	private Boolean paid = false; // 지불완료
	private Boolean sendedEmail = false; // 이메일 보냄
	private Boolean shipped = false; // 배송중
	private Boolean delivered = false; // 배송완료
	private Boolean deleted = false; // 주문취소
	
	public OrderState() {
		
	}

	public OrderState(Integer orderId, String orderState) {
		this.orderId = orderId;
		
		switch(orderState) {
		case OrderState.VirtualOrder:
			setOrderState(true,false,false,false,false,false,false);
			break;
		case OrderState.Activated:
			setOrderState(true,true,false,false,false,false,false);
			break;
		case OrderState.Paid:
			setOrderState(true,true,true,false,false,false,false);
			break;
		case OrderState.SendedEmail:
			setOrderState(true,true,true,true,false,false,false);
			break;
		case OrderState.Shipped:
			setOrderState(true,true,true,true,true,false,false);
			break;
		case OrderState.Delivered:
			setOrderState(true,true,true,true,true,true,false);
			break;
		case OrderState.Deleted:
			setOrderState(true,true,true,true,true,true,true);
			break;
		default:
			resetOrderState();
		}
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Boolean getVirtualOrder() {
		return virtualOrder;
	}

	public void setVirtualOrder(Boolean virtualOrder) {
		this.virtualOrder = virtualOrder;
	}

	public Boolean getActivated() {
		return activated;
	}

	public void setActivated(Boolean activated) {
		this.activated = activated;
	}

	public Boolean getPaid() {
		return paid;
	}

	public void setPaid(Boolean paid) {
		this.paid = paid;
	}

	public Boolean getSendedEmail() {
		return sendedEmail;
	}

	public void setSendedEmail(Boolean sendedEmail) {
		this.sendedEmail = sendedEmail;
	}

	public Boolean getShipped() {
		return shipped;
	}

	public void setShipped(Boolean shipped) {
		this.shipped = shipped;
	}

	public Boolean getDelivered() {
		return delivered;
	}

	public void setDelivered(Boolean delivered) {
		this.delivered = delivered;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	
	private void setOrderState(Boolean virtualOrder, Boolean activated, Boolean paid, Boolean sendedEmail, Boolean shipped, Boolean delivered, Boolean deleted) {
		this.virtualOrder = virtualOrder;
		this.activated = activated;
		this.paid = paid;
		this.sendedEmail = sendedEmail;
		this.shipped = shipped;
		this.delivered = delivered;
		this.deleted = deleted;
	}
	
	private void resetOrderState() {
		this.virtualOrder = false;
		this.activated = false;
		this.paid = false;
		this.sendedEmail = false;
		this.shipped = false;
		this.delivered = false;
		this.deleted = false;
	}

	public String getOrderState() {
		if(deleted)
			return OrderState.VirtualOrder;
		else if(delivered)
			return OrderState.Delivered;
		else if(shipped)
			return OrderState.Shipped;
		else if(sendedEmail)
			return OrderState.SendedEmail;
		else if(paid)
			return OrderState.Paid;
		else if(activated)
			return OrderState.Activated;
		else
			return OrderState.VirtualOrder;
	} 
}
