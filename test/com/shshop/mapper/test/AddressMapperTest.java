package com.shshop.mapper.test;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Address;
import com.shshop.domain.AddressProc;
import com.shshop.domain.User;
import com.shshop.mapper.AddressMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

public class AddressMapperTest {

	SqlSession sqlSession = null;
	UserMapper userMapper = null;
	AddressMapper addressMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		userMapper = sqlSession.getMapper(UserMapper.class);
		addressMapper = sqlSession.getMapper(AddressMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testInsertAddressProc() {
		userMapper.insertUserByEmail(new User("aa@gmail.com", "11111111"));

		User user = userMapper.getUserByEmail("aa@gmail.com", "11111111");

		AddressProc addressProc = new AddressProc(new Address(user.getUserId(), null, "detailAdd", "000", "111", "addrName", "111-222-3333"));
		addressMapper.insertAddressProc(addressProc);

		assertTrue(addressProc.getInsertedAddressId() > 0);
	}
	
	@Test
	public void testUpdateAddress() {
		userMapper.insertUserByEmail(new User("aa@gmail.com", "11111111"));

		User user = userMapper.getUserByEmail("aa@gmail.com", "11111111");

		AddressProc addressProc = new AddressProc(new Address(user.getUserId(), null, "detailAdd", "000", "111", "addrName", "111-222-3333"));
		addressMapper.insertAddressProc(addressProc);

		int addressId = addressProc.getInsertedAddressId();
		Address address = addressMapper.getAddressById(addressId);
		address.setPhoneNumber("010-3224-0196");
		addressMapper.updateAddress(address);
		address = addressMapper.getAddressById(addressId);
		
		assertTrue(address.getPhoneNumber().equals("010-3224-0196"));
	}
}
