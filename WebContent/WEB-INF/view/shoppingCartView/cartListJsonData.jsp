<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="totalPageCount" value="${orderViewInfo.pageDivider.totalPageCount}" />
	<json:property name="currentPage" value="${orderViewInfo.pageDivider.currentPage}" />
	<json:property name="pageDivNum" value="${orderViewInfo.pageDivider.pageDivNum}" />
	<json:property name="productsTotalPrice" value="${orderViewInfo.productsTotalPrice}" />
	<json:property name="totalPrice" value="${orderViewInfo.totalPrice}" />
	<json:property name="totalDescription" value="${orderViewInfo.totalDescription}" />
	<json:property name="productsTotalPrice" value="${orderViewInfo.productsTotalPrice}" />
	<json:property name="shippingTotalPrice" value="${orderViewInfo.shippingTotalPrice}" />
	
	<json:array name="currentPageInfos" var="item" items="${currentPageResults}">
		<json:object>
			<json:property name="productName" value="${item.product.name}" />
			<json:property name="productPrice" value="${item.product.price}" />
			<json:property name="productTotalPrice" value="${item.productTotalPrice}" />
			<json:property name="imageUrl" value="${item.imagePath}" />
 			<json:property name="shippingPrice" value="${item.shippingPrice}" />
 			<json:property name="quantity" value="${item.quantity}" />
 			<json:property name="orderPrice" value="${item.price}" />
 			<json:property name="isUnChecked" value="${item.unchecked}" />
		</json:object>
	</json:array>
</json:object>