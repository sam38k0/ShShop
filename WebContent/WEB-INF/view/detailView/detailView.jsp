<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.system.*" %>
<%@page session= "true" import ="com.shshop.command.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:set var= "pageTitle" scope ="request" value= "Detail View"/>
<jsp:setProperty name= "adminBean" property ="headerPage" value="/WEB-INF/view/header.jsp" />
<jsp:setProperty name= "adminBean" property ="stylePage" value="/WEB-INF/view/detailView/detailViewStyle.jsp" />
<jsp:setProperty name= "adminBean" property ="contentPage" value="/WEB-INF/view/detailView/detailViewBody.jsp" />
<jsp:setProperty name= "adminBean" property ="scriptPage" value="/WEB-INF/view/detailView/detailViewScript.jsp" />
<jsp:setProperty name= "adminBean" property ="footerPage" value="/WEB-INF/view/footer.jsp" /> 
<jsp:include page= "/WEB-INF/view/index.jsp" />
