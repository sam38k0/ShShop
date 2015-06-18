<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="userId" value="${selectedAddressResult.addressOrigin.userId}" />
	<json:property name="addressName" value="${selectedAddressResult.addressOrigin.name}" />

	<json:property name="addrBasicAdd" value="${selectedAddressResult.addressOrigin.basicAdd}" />
	<json:property name="addrDetailAdd" value="${selectedAddressResult.addressOrigin.detailAdd}" />
 	<json:property name="addrPostNumHeader" value="${selectedAddressResult.addressOrigin.postNumHeader}" />
 	<json:property name="addrPostNumTail" value="${selectedAddressResult.addressOrigin.postNumTail}" />
 	<json:property name="addrPhoneNumberHead" value="${selectedAddressResult.addressOrigin.phoneNumberHead}" />
 	<json:property name="addrPhoneNumberMid" value="${selectedAddressResult.addressOrigin.phoneNumberMid}" />
 	<json:property name="addrPhoneNumberTail" value="${selectedAddressResult.addressOrigin.phoneNumberTail}" />
 
 	<json:property name="addrNewBasicAdd" value="${selectedAddressResult.addressNew.basicAdd}" />
	<json:property name="addrNewDetailAdd" value="${selectedAddressResult.addressNew.detailAdd}" />
 	<json:property name="addrNewPostNumHeader" value="${selectedAddressResult.addressNew.postNumHeader}" />
 	<json:property name="addrNewPostNumTail" value="${selectedAddressResult.addressNew.postNumTail}" />
 	<json:property name="addrNewPhoneNumberHead" value="${selectedAddressResult.addressNew.phoneNumberHead}" />
 	<json:property name="addrNewPhoneNumberMid" value="${selectedAddressResult.addressNew.phoneNumberMid}" />
 	<json:property name="addrNewPhoneNumberTail" value="${selectedAddressResult.addressNew.phoneNumberTail}" />
</json:object>

