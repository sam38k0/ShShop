<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title><c:out value='${pageTitle}'/></title>
		
		<!-- Basic Style -->
		<link href="${adminBean.contextPath}/content/css/normalize.css" rel="stylesheet">
		<link href="${adminBean.contextPath}/content/css/main.css" rel="stylesheet">
		<link href="${adminBean.contextPath}/content/css/command.css" rel="stylesheet" type="text/css">
		<link href="${adminBean.contextPath}/content/css/user.css" rel="stylesheet" type="text/css">
		<style> input.error{border:1px dashed red;} </style> 
		
		<!-- Each Style -->
     	<jsp:include page= '${sessionScope.adminBean.stylePage}'/>
     	
     	<script src="${adminBean.contextPath}/content/js/modernizr-2.8.3.min.js"></script>
    </head>
    
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <div class="wrap">
            <div class="header_area">
                <jsp:include page= '${sessionScope.adminBean.headerPage}'/>
            </div>
            <div id="main_body">
				<jsp:include page= '${sessionScope.adminBean.contentPage}'/>
            </div>
            <div class="footer_area">
                <jsp:include page= '${sessionScope.adminBean.footerPage}'/>
            </div>
        </div>
        
        <!-- Basic JS -->        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script> window.jQuery || document.write('<script src="${adminBean.contextPath}/content/js/jquery-1.9.1.js"></script>')</script>
		<script src="${adminBean.contextPath}/content/js/initialize.js"></script>
		<script src="${adminBean.contextPath}/content/js/user.js"></script>
		
        <!-- Each JS -->     
	 	<jsp:include page= '${sessionScope.adminBean.scriptPage}'/>
	 	
	 	<script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='https://www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X','auto');ga('send','pageview');
        </script>
    </body>
    
</html>

 

    
    