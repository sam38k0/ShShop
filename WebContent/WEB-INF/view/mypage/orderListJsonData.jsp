<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="buyTotalPageCount" value="${buyOrderInfoList.pageDivider.totalPageCount}"/>
	<json:property name="buyCurrentPage" value="${buyOrderInfoList.pageDivider.currentPage}"/>
	<json:property name="buyPageDivNum" value="${buyOrderInfoList.pageDivider.pageDivNum}"/>
	<json:property name="sellTotalPageCount" value="${sellOrderInfoList.pageDivider.totalPageCount}"/>
	<json:property name="sellCurrentPage" value="${sellOrderInfoList.pageDivider.currentPage}"/>
	<json:property name="sellPageDivNum" value="${sellOrderInfoList.pageDivider.pageDivNum}"/>
	<json:property name="boardTotalPageCount" value="${boardInfo.pageDivider.totalPageCount}"/>
	<json:property name="boardCurrentPage" value="${boardInfo.pageDivider.currentPage}"/>
	<json:property name="boardPageDivNum" value="${boardInfo.pageDivider.pageDivNum}"/>
	
	<json:array name="currentPageInfosBuying" var="item" items="${currentPageResultsBuying}">
		<json:object>
			<json:property name="orderId" value="${item.order.orderId }" />
			<json:property name="imageUrl" value="${item.imagePath}" />
			<json:property name="productId" value="${item.product.productId }"/>
			<json:property name="productName" value="${item.product.name}" />
			<json:property name="orderPrice" value="${item.totalPrice}" />
			<json:property name="userName" value="${item.user.name}"/>
			<json:property name="basicAdd" value="${item.address.basicAdd}"/>
			<json:property name="detailAdd" value="${item.address.detailAdd}"/>
			<json:property name="userPhone" value="${item.user.phone}"/>
		</json:object>
	</json:array>
	<json:array name="currentPageInfosSelling" var="item" items="${currentPageResultsSelling}">
		<json:object>
			<json:property name="orderId" value="${item.order.orderId }" />
			<json:property name="imageUrl" value="${item.imagePath}" />
			<json:property name="productId" value="${item.product.productId }"/>
			<json:property name="productName" value="${item.product.name}" />
			<json:property name="orderPrice" value="${item.totalPrice}" />
			<json:property name="userName" value="${item.user.name}"/>
			<json:property name="basicAdd" value="${item.address.basicAdd}"/>
			<json:property name="detailAdd" value="${item.address.detailAdd}"/>
			<json:property name="userPhone" value="${item.user.phone}"/>
		</json:object>
	</json:array>
	<json:array name="currentPageInfosBoard" var="item" items="${currentPagesResultBoard}">
		<json:object>
			<json:property name="productId" value="${item.productId }"/>
			<json:property name="productName" value="${item.name}" />
			<json:property name="productPrice" value="${item.price}" />
			<json:property name="searchingCount" value="${item.searchingCount}"/>
			<json:property name="dateCreated" value="${item.dateCreated}"/>
		</json:object>
	</json:array>
</json:object>