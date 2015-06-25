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
			success : fnPageSet,
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
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
    
    function fnRegisterEvent() {
    	$('#idGoodsListOfbuying').unbind('click').bind('click', function (e) {
    		$.ajax({
    			type : "POST",
    			url : "setMypageListPaging",
    			data : {
    				'buyOrderKey' : '${requestScope.buyOrderKey}',
    				'sellOrderKey' : '${requestScope.sellOrderKey}',
    				'data-page' : '1'
    			},
    			success : buyFnPageSet,
    			error : function(ajaxContext) {
    			}
    		});
    	});
    	
    	$('#idGoodsListOfSelling').unbind('click').bind('click', function (e) {
			$.ajax({
				type : "POST",
				url : "setMypageListPaging",
				data : {
					'buyOrderKey' : '${requestScope.buyOrderKey}',
    				'sellOrderKey' : '${requestScope.sellOrderKey}',
					'data-page' : '1'
				},
				success : sellFnPageSet,
				error : function(ajaxContext) {
				}
			});
		});
    }
    
    $(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "setMypageListPaging",
			data : {
				'buyOrderKey' : '${requestScope.buyOrderKey}',
				'sellOrderKey' : '${requestScope.sellOrderKey}',
				'data-page' : '1'
			},
			success : sellFnPageSet,
			error : function(ajaxContext) {
			}
		});
		
		fnRegisterEvent();
	});
    
</script>