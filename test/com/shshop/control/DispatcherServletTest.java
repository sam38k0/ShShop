package com.shshop.control;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;

import com.oreilly.servlet.MultipartRequest;
import com.shshop.constant.Constant;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.ProductService;
import com.shshop.util.MyBatisUtil;

public class DispatcherServletTest {

	SqlSession sqlSession = null;

	@Mock
	private DispatcherServlet servlet;
	@Mock
	private HttpServletRequest request;
	@Mock
	private HttpServletResponse response;
	@Mock
	private HttpSession session;
	@Mock
	private ServletContext context;
	@Mock
	private PrintWriter writter;
	@Mock
	private MultipartRequest multi;

	@Before
	public void setUp() {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		servlet = new DispatcherServlet();
		request = mock(HttpServletRequest.class);
		response = mock(HttpServletResponse.class);
		session = mock(HttpSession.class);
		writter = mock(PrintWriter.class);
		multi = mock(MultipartRequest.class);
		context = mock(ServletContext.class);
		
		
		try {
			when(request.getSession()).thenReturn(session);
			when(response.getWriter()).thenReturn(writter);
			when(request.getSession(false)).thenReturn(session);
			when(request.getServletContext()).thenReturn(context);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testDoLoginProcess() {

		try {
			when(request.getParameter("email")).thenReturn("aaaa@gmail.com");
			when(request.getParameter("password")).thenReturn("tttt");

			CommandResult cmdResult = new AuthenticatorService(request, response).doLoginProcess();
			assertTrue("testLoginWithInvalidInformation", cmdResult.getContent() != "Success");

			when(request.getParameter("email")).thenReturn("");
			when(request.getParameter("password")).thenReturn("tttt");
			cmdResult = new AuthenticatorService(request, response).doLoginProcess();
			assertTrue("testLoginWithInvalidInformation", cmdResult.getContent() != "Success");

			when(request.getParameter("email")).thenReturn("aaaa@gmail.com");
			when(request.getParameter("password")).thenReturn("");
			cmdResult = new AuthenticatorService(request, response).doLoginProcess();
			assertTrue("testLoginWithInvalidInformation", cmdResult.getContent() != "Success");

			when(request.getParameter("email")).thenReturn("name1@gmail.com");
			when(request.getParameter("password")).thenReturn("1111");
			cmdResult = new AuthenticatorService(request, response).doLoginProcess();
			assertTrue("testLoginWithInvalidInformation", cmdResult.getContent() == "Success");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testInsertProduct() {

		try { 
			when(multi.getParameter("productname")).thenReturn("product");
			when(multi.getParameter("price")).thenReturn("1000");
			when(multi.getParameter("stock")).thenReturn("100");
			when(multi.getParameter("description")).thenReturn("product-description");
			when(multi.getParameter("tagsinput")).thenReturn("tagsinput");
			when(multi.getParameter("miniCategory")).thenReturn("");
			when(multi.getParameter("transactionType")).thenReturn("1");
			when((User)session.getAttribute(Constant.attrUser)).thenReturn(null); 
			CommandResult cmdResult = new ProductService(request,response).insertProduct();
			assertTrue("testInsertProduct", cmdResult.getContent() == Constant.noUser); 
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	} 
}
