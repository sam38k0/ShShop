<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/bootstrap-tagsinput.js"></script>
<script src="${adminBean.contextPath}/content/js/product.js"></script>
 
 <script>
 	$(document).ready(function() {
 		//카테고리 선택
 		$("#insertProduct_category>ul>li>ul>li").bind('click',function() {
 			$("#insertProduct_category>ul>li>ul>li").css({"background-color":"#eee","border-right":"2px solid #D8D8D8","border-bottom":"3px solid #D8D8D8","border-left":"1px solid #fff","border-top":"1px solid #fff","box-sizing":"border-box"});
 			$(this).css({"background-color":"#fff","border-left":"2px solid #D8D8D8","border-top":"3px solid #D8D8D8","border-right":"1px solid #fff","border-bottom":"1px solid #fff","box-sizing":"border-box"});
 			if ($(this).children().next().css("display")=="block") {
 				/* $(this).children().next().slideUp("1000"); */
 				$(this).css({"background-color":"#eee","border-right":"2px solid #D8D8D8","border-bottom":"3px solid #D8D8D8","border-left":"1px solid #fff","border-top":"1px solid #fff","box-sizing":"border-box"});
 			} else {
 				var showList=$(this).index();
 				$("#insertProduct_category>ul>li>ul>li>ul").slideUp("1000");
 				$(this).children().next().slideDown("1000");
 			}
 		});
 	 	
 	 	$("th").click(function() {
 	 		$("th").css("background-color","#fafafa");
 	 		$(this).css("background-color","#FBEFF2");
 	 		$(this).next().find("input:first").focus();
 	 		$(this).next().find("textarea").focus();
 	 		$(this).next().find("select").focus();
 	 	});
 	 	
 	 	$("td").click(function() {
 	 		$("th").css("background-color","#fafafa");
 	 		$(this).prev().css("background-color","#FBEFF2");
 	 	});
 	});
	
 </script>