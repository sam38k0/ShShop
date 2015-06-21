<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<json:object>
	<json:property name="addrIndex" value="${addressIndex}" />
	<json:property name="userName" value="${userName}" />
	
	<json:property name="addressName" value="${selectedAddressResult.addressOrigin.name}" />
	<json:property name="addressPhoneNumber" value="${selectedAddressResult.addressOrigin.phoneNumber}" />
 	<json:property name="addressPhoneNumberHead" value="${selectedAddressResult.addressOrigin.phoneNumberHead}" />
 	 <json:property name="addressPhoneNumberMid" value="${selectedAddressResult.addressOrigin.phoneNumberMid}" />
 	 <json:property name="addressPhoneNumberTail" value="${selectedAddressResult.addressOrigin.phoneNumberTail}" />
 	
 	<json:property name="addrPostNumHeader" value="${selectedAddressResult.addressOrigin.postNumHeader}" />
 	<json:property name="addrPostNumTail" value="${selectedAddressResult.addressOrigin.postNumTail}" />
 	
	<json:property name="addrBasicAdd" value="${selectedAddressResult.addressOrigin.basicAdd}" />
 	<json:property name="addrNewBasicAdd" value="${selectedAddressResult.addressNew.basicAdd}" />
 	
	<json:property name="addrDetailAdd" value="${selectedAddressResult.addressOrigin.detailAdd}" />
</json:object>

