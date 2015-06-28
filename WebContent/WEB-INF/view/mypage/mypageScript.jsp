<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script src="${adminBean.contextPath}/content/js/mypage.js"></script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample6_postcode1").value = data.postcode1;
                document.getElementById("sample6_postcode2").value = data.postcode2;
                document.getElementById("sample6_address2").value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_address2").focus();
            }
        }).open();
    }
    
    function sellFnPageSet(text) {
    	response = text;
    	response = $.parseJSON(response);
    	var sellTotalPageCount = response.sellTotalPageCount;
    	var sellCurrentPage = response.sellCurrentPage;
    	var sellPageDivNum = response.sellPageDivNum;
    	
    	var sellListHtml = '';
    	
    	$.each(response.currentPageInfosSelling, function(i,item) {
    		
    		sellListHtml += 
    			 '<tr>'+
		            '<td>' + item.orderId + '</td>'+
		            '<td><img src="/ShShopTest' + item.imageUrl +'\"><span>' + item.productId + '</span><em>' + item.productName + '</em></td>'+
		            '<td>' + item.orderPrice + '</td>' +
		            '<td>' + item.basicAdd + '<br>' + item.detailAdd + '</td>' +
		            '<td>' + item.userName + '<br>' + item.userPhone + '</td>' +
		            '<td><span>배송 대기</span></td>' +
		        '</tr>';
    	});
    	
    	$('#sell_table tbody').empty();
    	$('#sell_table tbody').append(sellListHtml);
    	
    	var sellBtnHtml = '';
		if(sellCurrentPage > 1) {
			sellBtnHtml += '<a href=\"#\" id=\"similar_item_list_prev\" class=\"movepreB\">이전 아이템</a>';
		}
		
		sellBtnHtml += '<span id=\"similar_item_list_page\">';
		sellBtnHtml += '<strong>'+ sellCurrentPage +'</strong>/' + sellTotalPageCount;
		sellBtnHtml += '</span>'
		
		if(sellCurrentPage < sellTotalPageCount)
			sellBtnHtml += '<a href=\"#\" id=\"similar_item_list_next\" class=\"movenextB\">다음 아이템</a>';
	 
		$('.sellMoveBtn').empty();
		$('.sellMoveBtn').append(sellBtnHtml);
		
		$('.buy_table').hide();
		$('.board_table').hide();
		$('.sell_table').show();
		
		fnRegisterEvent();
    }
    
    function sellFnPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'sellOrderKey' : '${requestScope.sellOrderKey}',
				'dataPageInSell' : currentPage
			},
			success : sellFnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
    
    function sellFnPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'sellOrderKey' : '${requestScope.sellOrderKey}',
				'dataPageInSell' : currentPage
			},
			success : sellFnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
    
    function buyFnPageSet(text) {
    	response = text;
    	response = $.parseJSON(response);
    	var buyTotalPageCount = response.buyTotalPageCount;
    	var buyCurrentPage = response.buyCurrentPage;
    	var buyPageDivNum = response.buyPageDivNum;
    	
    	var buyListHtml = '';
    	
    	$.each(response.currentPageInfosBuying, function(i,item) {
    		
    		buyListHtml += 
    			 '<tr>'+
		            '<td>' + item.orderId + '</td>'+
		            '<td><img src="/ShShopTest' + item.imageUrl +'\"><span>' + item.productId + '</span><em>' + item.productName + '</em></td>'+
		            '<td>' + item.orderPrice + '</td>' +
		            '<td>' + item.basicAdd + '<br>' + item.detailAdd + '</td>' +
		            '<td>' + item.userName + '<br>' + item.userPhone + '</td>' +
		            '<td><span>배송 대기</span></td>' +
		        '</tr>';
    	});
    	
    	$('#buy_table tbody').empty();
    	$('#buy_table tbody').append(buyListHtml);
    	
    	var buyBtnHtml = '';
		if(buyCurrentPage > 1) {
			buyBtnHtml += '<a href=\"#\" id=\"similar_item_list_prev\" class=\"movepreB\">이전 아이템</a>';
		}
		
		buyBtnHtml += '<span id=\"similar_item_list_page\">';
		buyBtnHtml += '<strong>'+ buyCurrentPage +'</strong>/' + buyTotalPageCount;
		buyBtnHtml += '</span>'
		
		if(buyCurrentPage < buyTotalPageCount)
			buyBtnHtml += '<a href=\"#\" id=\"similar_item_list_next\" class=\"movenextB\">다음 아이템</a>';
	 
		$('.buyMoveBtn').empty();
		$('.buyMoveBtn').append(buyBtnHtml);
		
		$('.sell_table').hide();
		$('.board_table').hide();
		$('.buy_table').show();
		
		fnRegisterEvent();
    }
    
    function buyFnPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'buyOrderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage
			},
			success : buyFnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
    
    function buyFnPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'buyOrderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage
			},
			success : buyFnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
 
    
    function fnRegisterEvent() {
    	
    	//등록현황
    	$('#idGoodsforSelling1').unbind('click').bind('click', function (e) {
    		$('#wrapperContent2').css("display","block");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			 
    		$.ajax({
    			type : "POST",
    			url : "setMypageListPaging",
    			data : {
    				'dataPageOfMyProducts' : '1'
    			},
    			success : fnMyProductsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    		
    	});
    	
    	$('#idGoodsforSelling2').unbind('click').bind('click', function (e) {
    		$('#wrapperContent2').css("display","block");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			 
    		$.ajax({
    			type : "POST",
    			url : "setMypageListPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '1'
    			},
    			success : fnMyProductsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    		
    	});
    	
    	$('#idGoodsforSelling3').unbind('click').bind('click', function (e) {
    		$('#wrapperContent2').css("display","block");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			 
    		$.ajax({
    			type : "POST",
    			url : "setMypageListPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '2'
    			},
    			success : fnMyProductsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	//구매현황
    	$('#idGoodsforBuying1').unbind('click').bind('click', function (e) {
    		$('#wrapperContent').css("display","block");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageBuyPaging",
    			data : {
    				'dataPageOfMyProducts' : '1'
    			},
    			success : fnMyOrdersPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsforBuying2').unbind('click').bind('click', function (e) {
    		$('#wrapperContent').css("display","block");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageBuyPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '1'
    			},
    			success : fnMyOrdersPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsforBuying3').unbind('click').bind('click', function (e) {
    		$('#wrapperContent').css("display","block");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageBuyPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '2'
    			},
    			success : fnMyOrdersPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsforBuying4').unbind('click').bind('click', function (e) {
    		$('#wrapperContent').css("display","block");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","none");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageBuyPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '3'
    			},
    			success : fnMyOrdersPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	//배송현황
    	$('#idGoodsforDelivery1').unbind('click').bind('click', function (e) {

    	});
    	
    	$('#idGoodsforDelivery2').unbind('click').bind('click', function (e) {
 
    	});
    	
    	$('#idGoodsforDelivery3').unbind('click').bind('click', function (e) {

    	});
    	
    	//페이징
    	$('#similar_item_list_prev1').click(fnMyOrdersPagePrev);
		$('#similar_item_list_next1').click(fnMyOrdersPageNext);
		$('#similar_item_list_prev2').click(fnMyProductsPagePrev);
		$('#similar_item_list_next2').click(fnMyProductsPageNext);
    }
    
    //MyProductsPaging
    //
    function fnMyProductsPageSet(text) {
    	response = text;
    	response = $.parseJSON(response);

    	var totalPageCount = response.totalPageCount;
    	var currentPage = response.currentPage;
    	var pageDivNum = response.pageDivNum;
    	
    	var trHtml = '';
    	
    	$.each(response.currentPageData, function(i,item) {
    		
    		trHtml += 
			'<tr>' +
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\'><a href=\'#\'><font color=\'#1383E3\'><b>' + item.productId + '</b></font></a></td>' +
			'	<td width=\'1\'></td>' +
			'	<td bgcolor=\'#FFFFFF\' width=\'295\' height=\'32\' align=\'left\'>&nbsp;&nbsp;<a href=\'#\'><span class=\'txt120\'>' + item.productName + '</span></a></td>' +
			'	<td width=\'1\'></td>' +
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\'  class=\'price\'>' + item.productPrice +'</td>' +
			'	<td width=\'1\'></td>' +
			'	<td bgcolor=\'#FFFFFF\' width=\'100\' height=\'32\' align=\'center\'>' + item.searchingCount + '</td>' +
			'	<td width=\'1\'></td>' +
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\'>' + item.dateCreated + '</td>' +
			'</tr>' +
			'<tr>' +
			'	<td bgcolor=\'#E8E8E8\' height=\'1\' colspan=\'15\'></td>' +
			'</tr>';
    	});
    	
    	$('#idMyProductsListTbl tbody').empty();
    	$('#idMyProductsListTbl tbody').append(trHtml);
    	
		//Page Button
		var btnHtml = '';
		if(currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev2\" class=\"movepreB\">이전 아이템</a>';
		}
		
		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>'+ currentPage +'</strong>/' + totalPageCount;
		btnHtml += '</span>'
		
		if(currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next2\" class=\"movenextB\">다음 아이템</a>';
	 
		$('#idMoveBtnForProducts').empty();
		$('#idMoveBtnForProducts').append(btnHtml);
 
		
		fnRegisterEvent(); 
    }
    
	function fnMyProductsPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMyProductsPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnMyProductsPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMyProductsPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	//MyOrderPaging
	function fnMyOrdersPageSet(text) {
    	response = text;
    	response = $.parseJSON(response);

    	var totalPageCount = response.totalPageCount;
    	var currentPage = response.currentPage;
    	var pageDivNum = response.pageDivNum;
    	
    	var trHtml = '';
    	
    	$.each(response.currentPageData, function(i,item) {
    		trHtml += 
			'<tr>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\'><a href=\'#\'><font color=\'#1383E3\'><b>' + item.orderId + '</b></font></a></td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\'>'+ item.dateCreated +'</td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'295\' height=\'32\' align=\'left\'>&nbsp;&nbsp;<a href=\'#\'><span class=\'txt120\'>' + item.productName + '</span></a></td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'100\' height=\'32\' align=\'center\'><b>' + item.price + '/</b>'+ item.amount+'</td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'80\' height=\'32\' align=\'center\' class=\'price\'>' + item.orderState+ '</td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'75\' height=\'32\' align=\'center\'>'+item.seller+'</td>'+
			'	<td width=\'1\'></td>'+
            '	<td bgcolor=\'#FFFFFF\' width=\'70\' height=\'32\' align=\'center\'>'+
            '	<a href=\'#\'>배송조회</a>'+
        	'	</td>'+
			'</tr>'+
			'<tr>'+
			'	<td bgcolor=\'#E8E8E8\' height=\'1\' colspan=\'15\'></td>'+
			'</tr>';
    	});
    	
    	$('#idMyOrderListTbl tbody').empty();
    	$('#idMyOrderListTbl tbody').append(trHtml);
    	
		//Page Button
		var btnHtml = '';
		if(currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev1\" class=\"movepreB\">이전 아이템</a>';
		}
		
		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>'+ currentPage +'</strong>/' + totalPageCount;
		btnHtml += '</span>'
		
		if(currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next1\" class=\"movenextB\">다음 아이템</a>';
	 
		$('#idMoveBtnForOrders').empty();
		$('#idMoveBtnForOrders').append(btnHtml);
 
		
		fnRegisterEvent(); 
    }
    
	function fnMyOrdersPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setMypageBuyPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMyOrdersPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnMyOrdersPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "setMypageBuyPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMyOrdersPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
 
 
	//OnLoad
	//
    $(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'dataPageOfMyProducts' : '1'
			},
			success : fnMyProductsPageSet,
			error : function(ajaxContext) {
			}
		});
		
		fnRegisterEvent();
	});
    
</script>