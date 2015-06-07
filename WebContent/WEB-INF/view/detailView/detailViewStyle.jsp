<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />
 
<link rel="stylesheet" href="${adminBean.contextPath}/content/css/detail.css" /> 

<%--
<!--[if !IE]><!-->
<style>
.accordion_list {
	position: relative;
    left: -40px;
} 
</style>
<!--<![end if]-->
 --%>

