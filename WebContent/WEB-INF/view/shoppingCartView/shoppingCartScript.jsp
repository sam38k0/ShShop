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
		
		//deliveryFee = parseInt($('#txtTotalDelvFare').text());
		
		totalAmount = totalPriceOfItems;
		
		totalDescription = "" + totalItems + " 종(" + totalQuantity + ")개";
		
		$('#lblTotalAmountCart').text("" + totalPriceOfItems + "원");
		$('#totalItemsPrice').html("<em>" + totalPriceOfItems + "</em>원");
		$('#txtTotalAmount').text("" + totalAmount );
		$('#totalDesciption').html("<em>" + totalDescription + "</em>");
	}
 
	
	function fnRegisterEvent() {
	    $('#chkCartHeader').change(function() {
	    	fnCheckedChangeChildCart();
	    	fnResetCartSummary();
	    });
	    
	    $('input:checkbox[name="chkCartGoodsShShop"]').change(function() {
	    	fnResetCartSummary();
	    });
	}
	
	$(document).ready(function() {
		fnPageInitialize();
		fnRegisterEvent();
	});
</script>

