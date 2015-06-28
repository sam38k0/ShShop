package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderProc;
import com.shshop.domain.User;

public interface OrderMapper {
	public void insertOrderProc(OrderProc orderProc);

	public void updateOrder(Order order);

	public List<Order> getOrder(@Param("userId") int userId); 
	
	public int getOrderCount(@Param("userId") Integer userId);
	
	public Address getBuyUserAdd(@Param("orderId") int orderId);

	public List<Order> getSellOrder(@Param("userId") int userId);
	
	public void deleteOrder(Order order);

	
}
