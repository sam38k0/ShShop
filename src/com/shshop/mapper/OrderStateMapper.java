package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.OrderState;

public interface OrderStateMapper {
	public void insertOrderState(OrderState orderState);

	public void updateOrderState(OrderState orderState);

	public List<OrderState> getOrderState(@Param("orderId") int orderId);
}
