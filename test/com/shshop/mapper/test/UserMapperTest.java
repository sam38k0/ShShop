package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Address;
import com.shshop.domain.AddressProc;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

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
		String email = "aa@gmail.com";
		String password = "11111111";
		String name = "name";
		String phone = "111-1111-1111";
		String ktalk = "ktalk";
		String birthday = "20011019";
		String bio = "biobio";
		java.sql.Date birthdaySqlDate = Format.getSqlDate(birthday);
 
		userMapper.insertUserByEmail(new User(email, password, name, phone, ktalk, bio, birthdaySqlDate)); 
		
		User user = userMapper.getUserByEmail("aa@gmail.com", "11111111");
		int userIdBefore = user.getUserId();
		
		user.setPassword("22");
		user.setName("name2");
		user.setEmail("bb@gamil.com");
		userMapper.updateUser(user);
		
		user = userMapper.getUserByEmail("bb@gamil.com", "22");
		int userIdAfter = user.getUserId();
		
		assertEquals("testUpdateNameByEmail1", user.getName(), "name2"); 
		assertEquals("testUpdateNameByEmail2", userIdAfter, userIdBefore);
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
		java.sql.Date birthdaySqlDate = Format.getSqlDate(birthday);
		
		int countBefore = userMapper.getUserCount();
		userMapper.insertUserByEmail(new User(email, password, name, phone, ktalk, bio, birthdaySqlDate)); 
		int countAfter = userMapper.getUserCount();
		assertEquals("testAddUser", countBefore + 1, countAfter);
	}
	
	@Test
	public void testInsertAddressProc() {
		userMapper.insertUserByEmail(new User("aa@gmail.com", "11111111"));  
		
		List<User> users = userMapper.getAllUsers();
 
		User user = users.get(0);
		
		AddressProc addressProc = new AddressProc(new Address(user.getUserId(),null,"detailAdd","000","111","addrName","111-222-3333"));
		userMapper.insertAddressProc(addressProc);
		
		assertTrue(addressProc.getInsertedAddressId()>0);
	}
//	
//	@Test
//	public void testUpdateAddress() {
//		
//	}
	
//	@Test
//	public void testAddUser() {
//		int countBefore = userMapper.getUserCount();
//		userMapper.insertUserByEmail(new User("aaaa", "1234"));
//		userMapper.insertUserByEmail(new User("bbbb", "11111"));
//		int countAfter = userMapper.getUserCount();
//		assertEquals("testAddUser", countBefore + 2, countAfter);
//	}
}
