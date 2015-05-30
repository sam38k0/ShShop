<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="totalSearchingCount" value="${totalSearchingCount}" />
	<json:array name="searchResults" var="item" items="${searchResults}">
		<json:object>
			<json:property name="id" value="${item.id}" />
			<json:property name="userName" value="${item.userName}" />
			<json:property name="productName" value="${item.productName}" />
			<json:property name="price" value="${item.price}" />
			<json:property name="dataCreated" value="${item.dataCreated}" />
			<json:property name="safeOrder" value="${item.safeOrder}" />
 			<json:property name="imageUrl" value="${item.imageUrl}" />
 			<json:property name="location" value="${item.location}" />
 			<json:property name="userLevel" value="${item.userLevel}" />
		</json:object>
	</json:array>
</json:object>