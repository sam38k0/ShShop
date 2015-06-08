package com.shshop.mapper;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.OrderState;

public interface OrderStateMapper {
	public void insertOrderState(OrderState orderState);
	
	public void updateOrderState(OrderState orderState);
	
	public OrderState selectOrderState(@Param("orderId") int orderId);
}
