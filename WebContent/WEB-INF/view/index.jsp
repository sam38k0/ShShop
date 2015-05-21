<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title><c:out value='${pageTitle}'/></title>
        <link href="../content/css/command.css" rel="stylesheet">
		<link href="../content/css/user.css" rel="stylesheet">
		<style> input.error{border:1px dashed red;} </style> 
        
		<script src="../content/js/jquery-1.9.1.js"></script>
		<script src="../content/js/checklogin.js"></script>
		<script src="../content/js/modal.js"></script>
		<script src="../content/js/user.js"></script>
    </head>
    <body>
        <div class="wrap">
            <div class="header_area">
                <jsp:include page= '<%= adminBean.getHeaderPage() %>'/>
            </div>
            <div id="main_body">
				<jsp:include page= '<%= adminBean.getContentPage() %>'/>
            </div>
            <div class="footer_area">
                <jsp:include page= '<%= adminBean.getFooterPage() %>'/>
            </div>
        </div>
    </body>
</html>