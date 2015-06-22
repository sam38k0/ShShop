<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/common.js"></script>

<script type="text/javascript">

	//페이지 초기화
	function fnPageInitialize(event) {
		$("#chkCartHeader").prop('checked', true);
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			if ($(this).attr("disabled") != "disabled") {
				$(this).prop('checked', true);
			}
		});
	}

	//Cart 상품 전체 선택/선택 해제
	function fnCheckedChangeChildCart() {
		var checked = false;

		if ($("#chkCartHeader").is(':checked')) {
			$("#chkCartHeader").prop('checked', true);
			checked = true;
		} else {
			$("#chkCartHeader").prop('checked', false);
			checked = false;
		}
		
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			if ($(this).attr("disabled") != "disabled") {
				$(this).prop('checked', checked);
			}
		});
		
		fnResetCartSummary();
	}

	//카트의 상품 정보 변경에 따른 뷰 변경
	function fnResetCartSummary() {
		var totalPriceOfItems = 0;
		var totalQuantity = 0;
		var totalItems = 0;
		var deliveryFee = 0;
		
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			if ($(this).is(':checked')) { 
				var checkedId = $(this).attr('id');
				var indx = checkedId.replace('chkCartGoodsShShop', '');
				var idTotalPriceOfItem = '#totalPricOfItem' + indx;
				var idTotalQuantity = '#txtGoodsCnt' +indx;
				totalPriceOfItems += parseInt($(idTotalPriceOfItem).attr('value'));
				totalQuantity +=  parseInt($(idTotalQuantity).attr('value'));
				totalItems += 1;
			}
		});
		
		var strDeliveryFee = fnReplaceAll($('#txtTotalDelvFare em').text(),',','');
 
		deliveryFee = parseInt(strDeliveryFee);
		
		totalAmount = deliveryFee + totalPriceOfItems;
		
		totalDescription = "" + totalItems + " 종(" + totalQuantity + ")개";
		
		$('#lblTotalAmountCart').text("" + totalPriceOfItems + "원");
		$('#totalItemsPrice').html("<em>" + totalPriceOfItems + "</em>원");
		$('#txtTotalAmount').text("" + totalAmount );
		$('#totalDesciption').html("<em>" + totalDescription + "</em>");
	}
 
	// 아이템의 수량 변경에 대한 리턴
	function fnAjaxChangeShippingItemCount(text) {
		fnAjaxLoaderLayerHide("divAjaxLoader");
		
		response = text;
		response = $.parseJSON(response);
		
		var orderIndex = response.orderIndex;
		var totalPrice = response.totalPrice;
		
		$('#totalPricOfItem' + orderIndex).text(totalPrice + '원');
		$('#totalPricOfItem' + orderIndex).attr('value', totalPrice);
		
		fnResetCartSummary();
		fnRegisterEvent();
	}
	
	function fnRegisterEvent() {
	    $('#chkCartHeader').change(function() {
	    	fnCheckedChangeChildCart();
	    	fnResetCartSummary();
	    });
	    
	    $('input:checkbox[name="chkCartGoodsShShop"]').change(function() {
	    	fnResetCartSummary();
	    }); 
	    
	    $('.chgnum').click(function() {
			var checkedId = $(this).attr('id');
			var indx = checkedId.replace('hdnOriginalGoodsCnt', '');
			var newQuantity = parseInt($('#txtGoodsCnt' + indx).val());
			$('#txtGoodsCnt' + indx).attr('value', newQuantity);
			
			if(newQuantity <= 0) {
				alert('유효하지 않은 수량을 입력하셨습니다.');
			}
			
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			
			$.ajax({
				type : 'POST',
				url : 'changeOrderItemCount',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'orderIndex' : indx,
					'itemNewQuantity' : newQuantity
				},
				success : fnAjaxChangeShippingItemCount,
				error : function(ajaxContext) {
					alert("변경된 수량으로 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	}
	
	$(document).ready(function() {
		fnPageInitialize();
		fnRegisterEvent();
	});
</script>

