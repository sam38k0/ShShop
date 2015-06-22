package com.shshop.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderProc;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.mapper.AddressMapper;
import com.shshop.mapper.OrderMapper;
import com.shshop.mapper.OrderStateMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.util.MyBatisUtil;

public class OrderService {
	private SqlSession sqlSession = null;

	public OrderService() {
	}

	public void insertOrderData(Order order) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.insertOrderProc(new OrderProc(order));
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

	public User selectSellInfo(int userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		User user;
		try {
			UserMapper orderMapper = sqlSession.getMapper(UserMapper.class);
			user = orderMapper.getUserById(userId);
		} finally {
			sqlSession.close();
		}
		return user;
	}

	public Address selectSellAddress(int addressId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		Address address;
		try {
			AddressMapper orderMapper = sqlSession.getMapper(AddressMapper.class);
			address = orderMapper.getAddressById(addressId);
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
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			product = productMapper.getProductById(productId);
		} finally {
			sqlSession.close();
		}
		return product;
	}
	
	public CommandResult changeOrderItemCount(HttpServletRequest request) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strOrderIndex = request.getParameter(Constant.attrOrderIndex);
		String strItemQuantity = request.getParameter(Constant.attrItemNewQuantity);
		
		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		
		List<OrderInfo> orderInfos = orderViewInfo.getOrderInfos();
		
		OrderInfo orderInfo = orderInfos.get(Integer.parseInt(strOrderIndex));
		orderInfo.setQuantity(Integer.parseInt(strItemQuantity));
		
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		 
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.updateOrder(orderInfo.getOrder());
		} finally {
			sqlSession.close();
		}
 
		return new CommandResult(Constant.textHtml, Constant.Success);
	}
}
