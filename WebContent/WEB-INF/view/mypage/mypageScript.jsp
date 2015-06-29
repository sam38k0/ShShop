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
    
    function fnRegisterEvent() {
    	$("#tab_menu li").unbind('click').bind('click', function (e) {
	   		$('.tabMyroom li').removeClass("on");
			$(this).addClass("on");
			
			var id = $(this).attr('id');
			
			if(id == 'idDealInfo') {
				
				$('.myroomWrap2').css("display","block");
	    		$('#wrapperContent2').css("display","block");
	    		$('#wrapperContent').css("display","none");
	    		$('#wrapperContent3').css("display","none");
		   		$('.depth3 li').removeClass("on");
				$('#idGoodsforSelling1').addClass("on");
				
				$('#user_wrap').css("display","none");
				
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
	    		
			} else if(id == 'idPersonalInfo'){
	    		$('#wrapperContent2').css("display","none");
	    		$('#wrapperContent').css("display","none");
	    		$('#wrapperContent3').css("display","none");
	    		$('.myroomWrap2').css("display","none");
	    		$('#user_wrap').css("display","block");
			}
    	});
    	
    	//등록현황
    	$('#idGoodsforSelling1').unbind('click').bind('click', function (e) {
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
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
    		$('#user_wrap').css("display","none");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","block");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageSellingPaging",
    			data : {
    				'dataPageOfMyProducts' : '1'
    			},
    			success : fnMySellsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsforDelivery2').unbind('click').bind('click', function (e) {
    		$('#user_wrap').css("display","none");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","block");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageSellingPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '1'
    			},
    			success : fnMySellsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsforDelivery3').unbind('click').bind('click', function (e) {
    		$('#user_wrap').css("display","none");
    		$('#wrapperContent').css("display","none");
    		$('#wrapperContent2').css("display","none");
    		$('#wrapperContent3').css("display","block");
	   		$('.depth3 li').removeClass("on");
			$(this).addClass("on");
			
    		$.ajax({
    			type : "POST",
    			url : "setMypageSellingPaging",
    			data : {
    				'dataPageOfMyProducts' : '1',
    				'data-page-filter' : '2'
    			},
    			success : fnMySellsPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	//페이징
    	$('#similar_item_list_prev1').click(fnMyOrdersPagePrev);
		$('#similar_item_list_next1').click(fnMyOrdersPageNext);
		$('#similar_item_list_prev2').click(fnMyProductsPagePrev);
		$('#similar_item_list_next2').click(fnMyProductsPageNext);
		$('#similar_item_list_prev3').click(fnMySellsPagePrev);
		$('#similar_item_list_next3').click(fnMySellsPageNext);
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

	//MySellingPaging
	function fnMySellsPageSet(text) {
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
			'	<td bgcolor=\'#FFFFFF\' width=\'200\' height=\'32\' align=\'left\'>&nbsp;&nbsp;<a href=\'#\'><span class=\'txt120\'>' + item.productName + '</span></a></td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'100\' height=\'32\' align=\'center\'><b>' + item.price + '/</b>'+ item.amount+'</td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'125\' height=\'32\' align=\'center\' class=\'price\'>' + item.userPhone + '</td>'+
			'	<td width=\'1\'></td>'+
			'	<td bgcolor=\'#FFFFFF\' width=\'125\' height=\'32\' align=\'center\'>'+ item.basicAdd +' '+ item.detailAdd +'</td>'+
			'	<td width=\'1\'></td>'+
            '	<td bgcolor=\'#FFFFFF\' width=\'70\' height=\'32\' align=\'center\'>'+
            '	<a href=\'#\'>'+ item.seller + '</a>'+
        	'	</td>'+
			'</tr>'+
			'<tr>'+
			'	<td bgcolor=\'#E8E8E8\' height=\'1\' colspan=\'15\'></td>'+
			'</tr>';
    	});
    	
    	$('#idMySellListTbl tbody').empty();
    	$('#idMySellListTbl tbody').append(trHtml);
    	
		//Page Button
		var btnHtml = '';
		if(currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev3\" class=\"movepreB\">이전 아이템</a>';
		}
		
		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>'+ currentPage +'</strong>/' + totalPageCount;
		btnHtml += '</span>'
		
		if(currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next3\" class=\"movenextB\">다음 아이템</a>';
	 
		$('#idMoveBtnForSells').empty();
		$('#idMoveBtnForSells').append(btnHtml);
 
		
		fnRegisterEvent(); 
    }
    
	function fnMySellsPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "setMypageSellingPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMySellsPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnMySellsPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "setMypageSellingPaging",
			data : {
				'data-page' : currentPage,
			},
			success : fnMySellsPageSet,
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