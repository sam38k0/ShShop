package com.shshop.mapper;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Order;
import com.shshop.domain.User;

public interface OrderMapper {
	public void insertOrder(Order order);
	
	public void updateOrder(Order order);
	
	public Order getBuyOrder(@Param("userId") int userId);
	
	public User getBuyUserInfo(@Param("userId") int userId);
	
	public Order getSellOrder(@Param("userId") int userId);
	
	public User getSellUserInfo(@Param("productId") int productId); 
}
