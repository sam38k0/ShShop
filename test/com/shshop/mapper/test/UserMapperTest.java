package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;
import com.shshop.util.SqlDataUtil;

public class UserMapperTest {

	SqlSession sqlSession = null;
	UserMapper userMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		userMapper = sqlSession.getMapper(UserMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testAddUser() {
		int countBefore = userMapper.getUserCount();
		userMapper.insertUserByEmail(new User("aaaa", "1234"));
		userMapper.insertUserByEmail(new User("bbbb", "11111"));
		int countAfter = userMapper.getUserCount();
		assertEquals("testAddUser", countBefore + 2, countAfter);
	}

	@Test
	public void testGetAllUsers() {
		List<User> users = userMapper.getAllUsers();
		assertNotNull("testGetAllUsers", users);
	}

	@Test
	public void testGetAllProductByUserID() {
		List<Product> products = userMapper.getAllProducts(1);
		assertNotNull("testGetAllUsers", products);
	}

	@Test
	public void testGetUserByUserId() {
		User user = userMapper.getUserById(1);
		assertNotNull("testGetUserByUserId", user);
	}

	@Test
	public void testGetUserByEmailAndPassword() {
		User user = new User("bbbb", "11111");
		userMapper.insertUser(user);

		User user2 = userMapper.getUserByEmail("bbbb", "11111");
		assertEquals("testGetUserByEmailAndPassword-email", user.getEmail(),
				user2.getEmail());
		assertEquals("testGetUserByEmailAndPassword-password",
				user.getPassword(), user2.getPassword());
	}

	@Test
	public void testUpdateNameByEmail() {
		User user = userMapper.getUserById(1);
		user.setUserId(1);
		user.setBankName("bank");
		user.setBankNum("1111-111-1111");
		user.setPhone("aaa-aaa-aaaa");
		userMapper.updateUser(user);

		User user2 = userMapper.getUserById(1);
		assertEquals("testUpdateNameByEmail1", user2.getBankName(), "bank");
		assertEquals("testUpdateNameByEmail2", user2.getBankNum(),
				"1111-111-1111");
		assertEquals("testUpdateNameByEmail3", user2.getPhone(), "aaa-aaa-aaaa");
	}

	@Test
	public void testInsertUser() {
		String email = "aa@gmail.com";
		String password = "11111111";
		String name = "name";
		String phone = "111-1111-1111";
		String ktalk = "ktalk";
		String birthday = "20011019";
		String bio = "biobio";
		java.sql.Date birthdaySqlDate = SqlDataUtil.getSqlDate(birthday);
		
		int countBefore = userMapper.getUserCount();
		userMapper.insertUserByEmail(new User(email, password, name, phone, ktalk, bio, birthdaySqlDate)); 
		int countAfter = userMapper.getUserCount();
		assertEquals("testAddUser", countBefore + 1, countAfter);
	}
}
