<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title><c:out value='${pageTitle}'/></title>
		
		<!-- Each Style -->
		<c:if test="${pageTitle eq 'Insert Product'}">
			<jsp:include page="product/insertProductStyle.jsp" />
		</c:if>
     	<c:if test="${pageTitle eq 'Detail View'}">
     		<jsp:include page="detailView/detailViewStyle.jsp" />
     	</c:if>
	 	
	 	
		<!-- Basic Style -->
		<link href="${adminBean.contextPath}/content/css/command.css" rel="stylesheet" type="text/css">
		<link href="${adminBean.contextPath}/content/css/user.css" rel="stylesheet" type="text/css">
		<style> input.error{border:1px dashed red;} </style> 

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
        
        <!-- Basic JS -->        
		<script src="${adminBean.contextPath}/content/js/jquery-1.9.1.js"></script>
		<script src="${adminBean.contextPath}/content/js/initialize.js"></script>
		<script src="${adminBean.contextPath}/content/js/user.js"></script>
		
        <!-- Each JS -->     
		<c:if test="${pageTitle eq 'Insert Product'}">
	  		<jsp:include page="product/insertProductScript.jsp" />
	 	</c:if>
	 	<c:if test="${pageTitle eq 'Detail View'}">
	  		<jsp:include page="detailView/detailViewScript.jsp" />
	 	</c:if>
    </body>
    
</html>

 

    
    