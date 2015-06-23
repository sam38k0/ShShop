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
		
		//Set CheckBox
		var hasUnchecked = false;
		$.each(response.currentPageInfos, function(i, item) { 
			if(item.isUnChecked) {
				$('#chkCartGoodsShShop' + i).prop('checked',false);
				hasUnchecked = true;
			} else {
				$('#chkCartGoodsShShop' + i).prop('checked',true);
			}
		});
		
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
		
		//Summery
		var totalDescription = response.totalDescription;
		var productsTotalPrice = response.productsTotalPrice;
		var shippingTotalPrice = response.shippingTotalPrice;
		
		var trSummery = '';
		trSummery +=
		'<td id=\"totalDesciption\"><em>' + totalDescription + '</em></td>' +
		'<td id=\"totalItemsPrice\"><em>' + productsTotalPrice + '</em>원</td>' +
		'<td id=\"txtTotalDelvFare\"><em>' + shippingTotalPrice + '</em>원</td>' +
		'<td class=\"clr1\">' +
		'	<em id=\"txtSaleAmount\">0</em>원' +
		'	<input type=\"hidden\" id=\"hdnSale\" value=\"0\">' +
		'</td>' +
		'<td class=\"clr2\">' +
		'	<em id=\"txtTotalAmount\">' + totalPrice +'</em>원' +
		'	<span id=\"spnGiftPackGbMemo2\" class=\"wfee\" display=\"none\" style=\"display: none;\">' +
		'		(선물포장비 <strong class=\"ls0\">1,000원</strong> 포함)' +
		'	</span>' +
		'</td>';
		
		$('#summeryTotal').empty();
		$('#summeryTotal').append(trSummery); 
	 
		//Event Reset
		fnAjaxLoaderLayerHide("divAjaxLoader");
		
		if(!hasUnchecked)
			$("#chkCartHeader").prop('checked', true);
		else
			$("#chkCartHeader").prop('checked', false);
		
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
	}
	
	function fnChangeItemCheckBox() {
    	var uncheckedIndex = ''; 
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			var id = $(this).attr('id');
			var indx = id.replace('chkCartGoodsShShop', ''); 
			
			if ($(this).is(':checked') == false) { 
				uncheckedIndex += indx + ',';
			}
		});
		
		$.ajax({
			type : 'POST',
			url : 'changeOrderItemChecked',
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'uncheckedIndx' : uncheckedIndex
			},
			success : fnPageSet,
			error : function(ajaxContext) {
				alert("해당 아이템의 업데이트에 실패하였습니다.");
				fnAjaxLoaderLayerHide("divAjaxLoader");
				fnRegisterEvent();
			}
		});
	}
 
	function fnRegisterEvent() {
	    $('#chkCartHeader').change(function() {
	    	fnCheckedChangeChildCart();
	    	
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2('chkCartHeader',"divAjaxLoader",50,30);	
			
			fnChangeItemCheckBox();
	    });
	    
	    $('input:checkbox[name="chkCartGoodsShShop"]').change(function() {
	    	var id = $(this).attr('id');
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2(id,"divAjaxLoader",50,30);	
			
			fnChangeItemCheckBox();
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
				success : fnPageSet,
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
				success : fnPageSet,
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

