package com.shshop.domain;

public class OrderState {
	private Integer orderId;
	private boolean virtualOrder; // 가상주문(장바구니 상태)
	private boolean activated; // 주문 활성화 여부
	private boolean paid; // 지불완료
	private boolean sendedEmail; // 이메일 보냄
	private boolean shipped; // 배송중
	private boolean delivered; // 배송완료
	private boolean deleted; // 주문취소
	
	
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
}
