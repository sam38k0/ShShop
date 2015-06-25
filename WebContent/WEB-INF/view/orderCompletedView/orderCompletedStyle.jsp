<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<link rel="stylesheet" href="${adminBean.contextPath}/content/css/httpsbutton.css" /> 
<link rel="stylesheet" href="${adminBean.contextPath}/content/css/httpspopup.css" /> 
<link rel="stylesheet" href="${adminBean.contextPath}/content/css/order.css" />

<style>
	.progbar .pay {
	  background-position: 0 -100px;
	}
	
	.fns_tbl_w {margin:0 0 40px 0;}
.fns_tbl_l {border-bottom:1px solid #979797;}
.fns_tbl_l th {background:#f5f5f5;border-top:2px solid #979797;border-bottom:1px solid #979797;}
.fns_tbl_l th .name {background-position:50% -250px;}
.fns_tbl_l th .fpri {background-position:50% -770px;}
.fns_tbl_l th .spri {background-position:50% -790px;}
.fns_tbl_l th .numb {background-position:50% -410px;}
.fns_tbl_l th .tota {background-position:50% -810px;}
	
</style>