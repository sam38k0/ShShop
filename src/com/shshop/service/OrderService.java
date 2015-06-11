package com.shshop.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.mapper.OrderMapper;
import com.shshop.mapper.OrderStateMapper;
import com.shshop.util.MyBatisUtil;

public class OrderService {
	private SqlSession sqlSession = null;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public OrderService(HttpServletRequest request,
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	public void insertOrderData(Order order) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.insertOrder(order);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateOrderData(Order order) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.updateOrder(order);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public List<Order> selectBuyOrder(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		List<Order> order;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			order = orderMapper.getBuyOrder(orderId);
		} finally {
			sqlSession.close();
		}
		return order;
	}
	
	public User selectBuyInfo(int userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		User user;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			user = orderMapper.getBuyUserInfo(userId);
		} finally {
			sqlSession.close();
		}
		return user;
	}
	
	public Address selectBuyAddress(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		Address address;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			address = orderMapper.getBuyUserAdd(orderId);
		} finally {
			sqlSession.close();
		}
		return address;
	}
	
	public List<Order> selectSellOrder(int userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		List<Order> order;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			order = orderMapper.getSellOrder(userId);
		} finally {
			sqlSession.close();
		}
		return order;
	}
	
	public User selectSellInfo(int productId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		User user;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			user = orderMapper.getSellUserInfo(productId);
		} finally {
			sqlSession.close();
		}
		return user;
	}
	
	public Address selectSellAddress(int productId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		Address address;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			address = orderMapper.getSellUserAdd(productId);
		} finally {
			sqlSession.close();
		}
		return address;
	}
	
	public void insertOrderState(OrderState orderState) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			osMapper.insertOrderState(orderState);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateOrderState(OrderState orderState) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			osMapper.updateOrderState(orderState);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public OrderState selectOrderState(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		OrderState orderState;
		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			orderState = osMapper.selectOrderState(orderId);
		} finally {
			sqlSession.close();
		}
		return orderState;
	}
	
	public Product selectProduct(int productId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		Product product;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			product = orderMapper.getProductInfo(productId);
		} finally {
			sqlSession.close();
		}
		return product;
	}
}
