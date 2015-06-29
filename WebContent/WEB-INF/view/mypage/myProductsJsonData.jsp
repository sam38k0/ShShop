<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="totalPageCount" value="${myProductsInfo.pageDivider.totalPageCount}"/>
	<json:property name="currentPage" value="${myProductsInfo.pageDivider.currentPage}"/>
	<json:property name="pageDivNum" value="${myProductsInfo.pageDivider.pageDivNum}"/>
	
	<json:array name="currentPageData" var="item" items="${myProductsInfo.pageDivider.currentPageData}">
		<json:object>
			<json:property name="productId" value="${item.productId }"/>
			<json:property name="productName" value="${item.name}" />
			<json:property name="productPrice" value="${item.price}" />
			<json:property name="searchingCount" value="${item.searchingCount}"/>
			<json:property name="dateCreated" value="${item.dateCreated}"/>
		</json:object>
	</json:array>
</json:object>