package com.shshop.mapper.test;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

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
import com.shshop.service.ProductService;
import com.shshop.util.MyBatisUtil;

public class OrderStateMapperTest {
	SqlSession sqlSession = null;
	OrderStateMapper orderStateMapper = null;
	UserMapper userMapper = null;
	ProductMapper productMapper = null;
	AddressMapper addressMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		orderStateMapper = sqlSession.getMapper(OrderStateMapper.class);
		userMapper = sqlSession.getMapper(UserMapper.class);
		productMapper = sqlSession.getMapper(ProductMapper.class);
		addressMapper = sqlSession.getMapper(AddressMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testUpdateOrderState() {
		List<User> users = userMapper.getAllUsers();
		if(users == null)
			assertTrue("testUpdateOrderState", false);
		
		List<Product> products = productMapper.getProducts(users.get(0).getUserId());
		if(products == null)
			assertTrue("testUpdateOrderState", false);
		
		List<Address> userAddresses = userMapper.getUserAddress(users.get(0).getUserId());
		if(userAddresses == null)
			assertTrue("testUpdateOrderState", false);

		Order order = new Order(users.get(0),products.get(0),userAddresses.get(0));

		OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
		OrderProc orderProc = new OrderProc(order);
		orderMapper.insertOrderProc(orderProc);

		int orderId = orderProc.getInsertedOrderId();
		order.setOrderId(orderId);
		OrderState orderState = new OrderState(orderId, OrderState.VirtualOrder);

		OrderStateMapper orderStateMapper = sqlSession.getMapper(OrderStateMapper.class);
		orderStateMapper.insertOrderState(orderState);
		
		orderState.setSendedEmail(true);
		orderStateMapper.updateOrderState(orderState);
		
		OrderState orderStateNew = orderStateMapper.getOrderState(orderId);
		
		assertTrue("testUpdateOrderState", orderStateNew.getOrderState() == orderState.getOrderState());
	}

}
