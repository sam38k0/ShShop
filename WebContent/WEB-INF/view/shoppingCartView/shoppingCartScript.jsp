<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/common.js"></script>

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
            '<tr id=\"orderItemList\"' + i +'>' +
            '<td class=\"cb\">' +
            '   <input type=\"checkbox\" class=\"chkbx\" name=\"chkCartGoodsShShop\" id=\"chkCartGoodsShShop' + i +'\"/>' +
            '</td>' +
            '<td class=\"goods_img\">' +
            '    <a href=\"#\" target=\"_new\" class=\"pd_a\">' +
            '        <img src="/ShShopTest' + item.imageUrl + '\" class=\"pdimg\"/>' +
            '    </a>' +
            '</td>' +
            '<td class=\"le\">' +
            '   <a href=\"#\" class=\"pd_a\">'+ item.productName+'</a>' +
            '    &nbsp;' +
            '</td>' +
            '<td>' + item.productPrice + '원</td>' +
            '<td>' +
            '    <input type=\"number\" id=\"txtGoodsCnt' + i +'\" name=\"txtGoodsCnt\" value="' + item.quantity + '\" class=\"ipubx num\" maxlength=\"4\" />' +
            '    <br/>' +
            '   <input type=\"hidden\" name=\"hdnOriginalGoodsCnt\" value=\"1\" class=\"ipubx num\" /><a href=\"#\" id=\"hdnOriginalGoodsCnt' + i +'\" title=\"변경\" class=\"bw chgnum\">변경</a>' +
            '</td>' +
            '<td><strong id=\"totalPricOfItem' + i +'\" value=\"'+ item.orderPrice +'\">'+ item.orderPrice +'원</strong>' +
            '</td>' + 
            '<td>' +
            '    <p class=\"dvmsg\">1일 이내 <br/>배송예정</p>' + 
            '</td>' + 
            '<td class=\"goods_order\">' + 
            '    <p class=\"ordbtnw\">' + 
            '    <a href=\"#\" title=\"주문하기\" id=\"orderItem' + i +'\" class=\"bw ordpd\">주문하기</a>' + 
            '    <a href=\"#\" title=\"삭제하기\" id=\"deleteItem' + i +'\" class=\"bw pddel\">삭제하기</a>' + 
            '    </p>' +
            '</td>' + 
        	'</tr>';
		});
		
		$('.cartTopItem tbody').empty();
		$('.cartTopItem tbody').append(trHTML);
		
		trHTML =   
        '<tr>' + 
        '    <td colspan=\"9\" class=\"tot\">일반카트 상품 총 금액 : ' + 
        '       <strong id=\"lblTotalAmountCart\">' + productsTotalPrice + '원</strong>' + 
        '       <span class=\"dvi\"> | </span>' + 
        '       ShShop포인트 총 적립액 : <strong id=\"lblTotalPointCart\">1,220원</strong> ' + 
        '       <span id=\"spnTotalPointDetailCart\">(기본 : 1,220원)</span>' + 
        '   </td>' + 
        '</tr>';
		
		$('.cartTopItem tfoot').empty();
		$('.cartTopItem tfoot').append(trHTML);
 
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
	 
		//Event Reset
		fnPageInitialize();
		fnRegisterEvent();
	}

	function fnPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setShoppingCartPage",
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
			url : "setShoppingCartPage",
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
	
	// 아이템 삭제에 대한 리턴
	function fnAjaxDeleteShippingItem(text) {
		fnAjaxLoaderLayerHide("divAjaxLoader");
		fnPageSet(text);
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
	    
	    $('.chgnum').unbind('click').bind('click', function (e) {
	    	event.preventDefault();
	    	
			var checkedId = $(this).attr('id');
			var indx = checkedId.replace('hdnOriginalGoodsCnt', '');
			var newQuantity = parseInt($('#txtGoodsCnt' + indx).val());
			$('#txtGoodsCnt' + indx).attr('value', newQuantity);
			
			if(newQuantity <= 0) {
				alert('유효하지 않은 수량을 입력하셨습니다.');
			}
			
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2('txtGoodsCnt' + indx,"divAjaxLoader",50,30);
			
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
	    
	    $('.pddel').unbind('click').bind('click', function (e) {
	    	event.preventDefault();
	    	
			var checkedId = $(this).attr('id');
			var indx = checkedId.replace('deleteItem', '');
			
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2(checkedId, "divAjaxLoader",50,30);
			
			$.ajax({
				type : 'POST',
				url : 'deleteOrder',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'orderIndex' : indx
				},
				success : fnAjaxDeleteShippingItem,
				error : function(ajaxContext) {
					alert("해당 아이템을 삭제하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
		$('#similar_item_list_prev').click(fnPagePrev);
		$('#similar_item_list_next').click(fnPageNext);
	}
	
	$(document).ready(function() {
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
</script>

