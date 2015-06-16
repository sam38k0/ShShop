package com.shshop.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.helper.RegExpressionHelper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

public class AuthenticatorService {
	private SqlSession sqlSession = null;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public AuthenticatorService(HttpServletRequest request,
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public CommandResult doLoginProcess() throws IOException {

		CommandResult result = null;

		try {
			String email = request.getParameter(Constant.attrEmail);
			String password = request.getParameter(Constant.attrPassword);

			boolean hasValidEmail = false;
			boolean hasPassword = false;

			if (email != null && email.trim().length() > 0
					&& RegExpressionHelper.isValidEmail(email)) {
				hasValidEmail = true;
			}

			if (password != null && password.trim().length() > 0) {
				hasPassword = true;
			}

			if (!hasValidEmail) {
				return new CommandResult(Constant.textHtml, Constant.wrongEmail);
			}

			if (!hasPassword) {
				return new CommandResult(Constant.textHtml, Constant.noPassword);
			}

			User user = getExistsUser(email, password);

			if (user == null) {
				return new CommandResult(Constant.textHtml, Constant.noUser);
			}

			HttpSession session = request.getSession();

			synchronized (session) {
				session.setAttribute(Constant.attrUser, user);
			}

			return new CommandResult(Constant.textHtml, Constant.Success);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public boolean canLogin(String email, String password) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		boolean loginResult = false;

		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			if (userMapper.getUserByEmail(email, password) != null) {
				loginResult = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}

		return loginResult;
	}

	public User getExistsUser(String email, String password) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		User user = null;

		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			user = userMapper.getUserByEmail(email, password);

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}

		return user;
	}

	public void insertProduct(Product product) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			ProductMapper productMapper = sqlSession
					.getMapper(ProductMapper.class);
			productMapper.insertProduct(product);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}

	public CommandResult registerUser(User user) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		int countBefore = 0, countAfter = 0;
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			countBefore = userMapper.getUserCount();
			userMapper.insertUser(user);
			countAfter = userMapper.getUserCount();
			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
		
		if (countAfter == countBefore + 1)
			return new CommandResult(Constant.textPlain, Constant.Success);
		else
			return new CommandResult(Constant.textPlain, Constant.Failed);
	}
	
	public User getViewSingleUser(Integer userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		User user = null;
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			user = userMapper.getSingleUser(userId);
		} finally {
			sqlSession.close();
		}
		return user;
	}
	
	public User getSelectUserId(String email) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		User user;
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			user = userMapper.getSelectUserId(email);
		} finally {
			sqlSession.close();
		}
		
		return user;
	}
	
	public void userDataUpdate(User user) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			userMapper.updateUser(user);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public List<Product> getProductTypeCount() {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		List<Product> product;
		
		try {
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			product = productMapper.selectMainCount();
			
		} finally {
			sqlSession.close();
		}
		
		return product;
	}
	
	public List<Product> getProductTypeDate() {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		List<Product> product;
		
		try {
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			product = productMapper.selectMainDate();
		} finally {
			sqlSession.close();
		}
		
		return product;
	}
	
	public List<Address> getUserAddress(Integer userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession(); 
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			List<Address> addresses = userMapper.getUserAddress(userId);
			return addresses; 
		} finally {
			sqlSession.close();
		} 
	}
	
	public void insertUserAddress(Address address) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			userMapper.insertAddress(address);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateUserAddress(Address address) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			userMapper.updateUserAddress(address);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
}
