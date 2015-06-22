package com.shshop.domain;

public class OrderState {
	public static final String VirtualOrder = "virtualOrder";
	public static final String Activated = "activated";
	public static final String Paid = "paid";
	public static final String SendedEmail = "sendedEmail";
	public static final String Shipped = "shipped";
	public static final String Delivered = "delivered";
	public static final String Deleted = "Deleted";
	
	private Integer orderId;
	private boolean virtualOrder = false; // 가상주문(장바구니 상태)
	private boolean activated = false; // 주문 활성화 여부
	private boolean paid = false; // 지불완료
	private boolean sendedEmail = false; // 이메일 보냄
	private boolean shipped = false; // 배송중
	private boolean delivered = false; // 배송완료
	private boolean deleted = false; // 주문취소

	public OrderState(String orderState) {
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

	public boolean isVirtualOrder() {
		return virtualOrder;
	}

	public void setVirtualOrder(boolean virtualOrder) {
		this.virtualOrder = virtualOrder;
	}

	public boolean isActivated() {
		return activated;
	}

	public void setActivated(boolean activated) {
		this.activated = activated;
	}

	public boolean isPaid() {
		return paid;
	}

	public void setPaid(boolean paid) {
		this.paid = paid;
	}

	public boolean isSendedEmail() {
		return sendedEmail;
	}

	public void setSendedEmail(boolean sendedEmail) {
		this.sendedEmail = sendedEmail;
	}

	public boolean isShipped() {
		return shipped;
	}

	public void setShipped(boolean shipped) {
		this.shipped = shipped;
	}

	public boolean isDelivered() {
		return delivered;
	}

	public void setDelivered(boolean delivered) {
		this.delivered = delivered;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	
	private void setOrderState(boolean virtualOrder, boolean activated, boolean paid, boolean sendedEmail, boolean shipped, boolean delivered, boolean deleted) {
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
	
}
