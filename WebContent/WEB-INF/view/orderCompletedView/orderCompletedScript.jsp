<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

<script type="text/javascript">
	$(document).ready(function() {
/* 		$(document).ready(function() {
			$.ajax({
				type : "POST",
				url : "setShoppingCartPage",
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'data-page' : '1',
				},
				success : fnPageSet,
				error : function(ajaxContext) {
				}
			});
		});
		fnPageInitialize();
		fnRegisterEvent(); */
	});
</script>

