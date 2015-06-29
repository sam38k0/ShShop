<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="pageDivNum" value="${myOrderInfo.pageDivider.pageDivNum}"/>
	<json:property name="totalPageCount" value="${myOrderInfo.pageDivider.totalPageCount}"/>
	<json:property name="currentPage" value="${myOrderInfo.pageDivider.currentPage}"/>
	
	<json:array name="currentPageData" var="item" items="${myOrderInfo.currentPageOrderInfos}">
		<json:object>
			<json:property name="orderId" value="${item.order.orderId }" />
			<json:property name="imageUrl" value="${item.imagePath}" />
			<json:property name="productId" value="${item.product.productId }"/>
			<json:property name="productName" value="${item.product.name}" />
			<json:property name="price" value="${item.order.cost}" />
			<json:property name="amount" value="${item.order.amount}" />
			<json:property name="orderState" value="${item.orderState.orderState}"/>
			<json:property name="seller" value="${item.user.name}"/>
			<json:property name="basicAdd" value="${item.address.basicAdd}"/>
			<json:property name="detailAdd" value="${item.address.detailAdd}"/>
			<json:property name="userPhone" value="${item.user.phone}"/>
			<json:property name="dateCreated" value="${item.order.dateCreatedStr}"/>
		</json:object>
	</json:array>
</json:object>