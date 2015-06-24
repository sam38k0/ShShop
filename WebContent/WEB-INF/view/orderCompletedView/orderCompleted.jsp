<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.system.*" %>
<%@page session= "true" import ="com.shshop.command.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:set var= "pageTitle" scope ="request" value= "ShShop"/>
<jsp:setProperty name= "adminBean" property ="headerPage" value="/WEB-INF/view/header.jsp" />
<jsp:setProperty name= "adminBean" property ="stylePage" value="/WEB-INF/view/orderCompletedView/orderCompletedStyle.jsp" />
<jsp:setProperty name= "adminBean" property ="contentPage" value="/WEB-INF/view/orderCompletedView/orderCompletedBody.jsp" />
<jsp:setProperty name= "adminBean" property ="scriptPage" value="/WEB-INF/view/orderCompletedView/orderCompletedScript.jsp" />
<jsp:setProperty name= "adminBean" property ="footerPage" value="/WEB-INF/view/footer.jsp" /> 
<jsp:include page= "/WEB-INF/view/index.jsp" />