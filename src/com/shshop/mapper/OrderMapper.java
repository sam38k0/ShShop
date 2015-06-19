package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.User;

public interface OrderMapper {
	public void insertOrder(Order order);

	public void updateOrder(Order order);

	public List<Order> getBuyOrder(@Param("userId") int userId);

	public User getBuyUserInfo(@Param("orderId") int orderId);

	public Address getBuyUserAdd(@Param("orderId") int orderId);

	public List<Order> getSellOrder(@Param("userId") int userId);
}
