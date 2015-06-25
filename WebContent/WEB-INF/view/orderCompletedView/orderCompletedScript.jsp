<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

<script type="text/javascript">
	//페이지 처리
	function fnPageSet(text) {
			
		response = text;
		response = $.parseJSON(response);
		var totalPageCount = response.totalPageCount;
		var currentPage = response.currentPage;
		var pageDivNum = response.pageDivNum;
		var totalPrice = response.totalPrice;
		var productsTotalPrice = response.productsTotalPrice;
		
		var trHTML = '';
		
		//Table
		$.each(response.currentPageInfos, function(i, item) {    	
	    	trHTML +=  
			'<tr class=last sizcache=\"12\" sizset=\"318\">' +
			'<td class=\"goods_img le\" sizcache=\"12\" sizset=\"318\">' +
			'	<img class=pdimg alt="" src="/ShShopTest' + item.imageUrl + '\"></td>' +
			'<td class=le sizcache=\"12\" sizset=\"319\">' + item.productName +'</td>' +
			'<td>' + item.orderPrice + '</td>' +
			'<td>' + item.quantity + '</td>' +
			'<td><STRONG>' + item.orderPrice + '원</STRONG></td></tr>';
		});
		
		$('#divGoods tbody').empty();
		$('#divGoods tbody').append(trHTML);
 
		//Page Button
		var btnHtml = '';
		if(currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev\" class=\"movepreB\">이전 아이템</a>';
		}
		
		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>'+ currentPage +'</strong>/' + totalPageCount;
		btnHtml += '</span>'
		
		if(currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next\" class=\"movenextB\">다음 아이템</a>';
	 
		$('.moveBtn').empty();
		$('.moveBtn').append(btnHtml);
		
		fnRegisterEvent();
	}
	
	function fnPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "orderPage",
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage,
			},
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "orderPage",
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage,
			},
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnRegisterEvent() {
		$('#similar_item_list_prev').click(fnPagePrev);
		$('#similar_item_list_next').click(fnPageNext);
		$(window).on("beforeunload", function(){
			$.ajax({
				type : "POST",
				url : "deleteOrderInfo",
				error : function(ajaxContext) {
				}
			}); 
	    });
	}
 
	$(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "orderPage",
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'data-page' : '1',
			},
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		}); 
		fnRegisterEvent();
	});
</script>

