<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.system.*" %>
<%@page session= "true" import ="com.shshop.command.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:set var= "pageTitle" scope ="request" value= "Insert Product"/>
<jsp:setProperty name= "adminBean" property ="headerPage" value="/WEB-INF/view/header.jsp" />
<jsp:setProperty name= "adminBean" property ="contentPage" value="/WEB-INF/view/insertProductBody.jsp" />
<jsp:setProperty name= "adminBean" property ="footerPage" value="/WEB-INF/view/footer.jsp" /> 
<jsp:include page= "/WEB-INF/view/index.jsp" />



 


 