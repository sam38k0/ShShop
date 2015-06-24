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
</json:object>