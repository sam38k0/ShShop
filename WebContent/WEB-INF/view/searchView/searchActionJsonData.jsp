<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="keywords" value="${searchResult.keywords}" />
	<json:property name="totalSearchingCount" value="${searchResult.totalSize}" />
	<json:property name="totalPageCount" value="${searchResult.totalPageCount}" />
	<json:property name="currentPage" value="${searchResult.currentPage}" />
	<json:array name="searchResults" var="item" items="${searchResult.currentPageResult}">
		<json:object>
			<json:property name="userName" value="${item.userName}" />
			<json:property name="productName" value="${item.productName}" />
			<json:property name="price" value="${item.price}" />
			<json:property name="dataCreated" value="${item.dataCreated}" />
			<json:property name="safeOrder" value="${item.safeOrder}" />
 			<json:property name="imageUrl" value="${item.imageUrl}" />
 			<json:property name="location" value="${item.location}" />
 			<json:property name="hitCount" value="${item.hitCount}" />
 			<json:property name="userLevel" value="${item.userLevel}" />
 			<json:property name="totalPageNum" value="${totalPageNum}" />
 			<json:property name="productId" value="${item.productId}" />
		</json:object>
	</json:array>
</json:object>

