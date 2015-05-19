package com.shshop.service;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.shshop.control.CommandResult;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;
import com.shshop.util.RegExpressionUtil;

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

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		boolean hasValidEmail = false;
		boolean hasPassword = false;

		if (email != null && email.trim().length() > 0
				&& RegExpressionUtil.isValidEmail(email)) {
			hasValidEmail = true;
		}

		if (password != null && password.trim().length() > 0) {
			hasPassword = true;
		}

		if (!hasValidEmail) {
			return new CommandResult("text/html","이메일 입력 형식 정보가 잘못 되었습니다.");
		}

		if (!hasPassword) {
			return new CommandResult("text/html","패스워드를 입력하시지 않았습니다.");
		}

		User user = getExistsUser(email, password);

		if (user == null) {
			return new CommandResult("text/html","사용자 정보를 찾을 수 없습니다.");
		}

		HttpSession session = request.getSession();
 
		synchronized (session) {
			session.setAttribute("user", user);
		}
		
		return new CommandResult("text/html","Success");
	}

	public boolean canLogin(String email, String password) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		boolean loginResult = false;

		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			if (userMapper.getUserByEmail(email, password) != null) {
				loginResult = true;
			}

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
		
		int countBefore,countAfter;
		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			countBefore = userMapper.getUserCount();
			userMapper.insertUser(user);
			countAfter = userMapper.getUserCount();
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		if(countAfter == countBefore + 1)
			return new CommandResult("text/plain;charset=UTF-8", "Success");
		else
			return new CommandResult("text/plain;charset=UTF-8", "Failed");
	}
}
