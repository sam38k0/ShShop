package com.shshop.control;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;

import com.shshop.command.Command;
import com.shshop.control.CommandResult;
import com.shshop.control.DispatcherServlet;
import com.shshop.mapper.ProductMapper;
import com.shshop.service.AuthenticatorService;
import com.shshop.util.MyBatisUtil;

public class DispatcherServletTest {
	
	SqlSession sqlSession = null; 
	
	@Mock  private DispatcherServlet servlet;
	@Mock  private HttpServletRequest request;
	@Mock  private HttpServletResponse response;
	@Mock  private HttpSession session;
	@Mock  private PrintWriter writter;

    @Before
    public void setUp() {
    	sqlSession = MyBatisUtil.getSqlSessionFactory().openSession(); 
        servlet = new DispatcherServlet();
        request = mock(HttpServletRequest.class );      
        response = mock(HttpServletResponse.class );    
        session = mock(HttpSession.class);
        writter = mock(PrintWriter.class);
   }
    
	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testDoLoginProcess() {

        try {
            when(request.getParameter( "email" )).thenReturn("aaaa@gmail.com" );
            when(request.getParameter( "password" )).thenReturn("tttt" );
            when(request.getSession()).thenReturn(session); 
            when(response.getWriter()).thenReturn(writter);
            
			CommandResult cmdResult = new AuthenticatorService(request, response).doLoginProcess(); 
	    	assertTrue("testLoginWithInvalidInformation",cmdResult.getContent()!="Success");
	    	
            when(request.getParameter( "email" )).thenReturn("" );
            when(request.getParameter( "password" )).thenReturn("tttt" );
			cmdResult = new AuthenticatorService(request, response).doLoginProcess(); 
	    	assertTrue("testLoginWithInvalidInformation",cmdResult.getContent()!="Success");
	    	
            when(request.getParameter( "email" )).thenReturn("aaaa@gmail.com" );
            when(request.getParameter( "password" )).thenReturn("" );
			cmdResult = new AuthenticatorService(request, response).doLoginProcess(); 
	    	assertTrue("testLoginWithInvalidInformation",cmdResult.getContent()!="Success");
	    	
            when(request.getParameter( "email" )).thenReturn("name1@gmail.com" );
            when(request.getParameter( "password" )).thenReturn("1111" );
			cmdResult = new AuthenticatorService(request, response).doLoginProcess(); 
	    	assertTrue("testLoginWithInvalidInformation",cmdResult.getContent()=="Success");
	    	
		} catch (IOException e) { 
			e.printStackTrace();
		}
	}
}

 