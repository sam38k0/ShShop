<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<link rel="stylesheet" href="${adminBean.contextPath}/content/css/httpsbutton.css" /> 
<link rel="stylesheet" href="${adminBean.contextPath}/content/css/httpspopup.css" /> 
<link rel="stylesheet" href="${adminBean.contextPath}/content/css/order.css" />
<style>
	.progbar .pay {
	  background-position: 0 -100px;
	}
</style>