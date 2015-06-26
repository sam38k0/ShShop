<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/jquery-1.11.0.min.js"></script>
<script src="${adminBean.contextPath}/content/js/detail.js"></script>

<script type="text/javascript">

	ajaxChildObject = null;
	
	function pagePrev(event) {
		event.preventDefault();
	
		var keywords = $('#keywords').val();
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "similarItemAction",
			data : {
				"productId" : '${productDetail.product.productId}',
				"data-page" : currentPage
			},
			success : pageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function pageNext(event) {
		event.preventDefault();
	
		var keywords = $('#keywords').val();
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "similarItemAction",
			data : {
				"productId" : '${productDetail.product.productId}',
				"data-page" : currentPage
			},
			success : pageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function textAreaEnter(e) {
	    var code = (e.keyCode ? e.keyCode : e.which);
	    
	 	if(code == 13) { //Enter keycode
	 		var text = $(this).val();
	 		if(text === null || text === '')
	 			return;
	 	
	 		$.ajax({
	 			type : "POST",
	 			url : "commentPostAction",
	 			data : {
	 				"productId" : '${productDetail.product.productId}',
	 				"comment" : text
	 			},
	 			success : commentSet,
	 			error : function(ajaxContext) {
	 			}
	 		});
	 	}
	}
	 
	function textAreaChildEnter(e) {
	    var code = (e.keyCode ? e.keyCode : e.which);
	    
	 	if(code == 13) { //Enter keycode 
	 	
	 		var text = $(this).val();
	 		if(text === null && text === '')
	 			return;
	 	
	 		var parentId = $(this).attr('id');
	 		
	 		$.ajax({
	 			type : "POST",
	 			url : "commentPostAction",
	 			data : {
	 				"productId" : '${productDetail.product.productId}',
	 				"comment" : text,
	 				"parentId" : parentId
	 			},
	 			success : commentSet,
	 			error : function(ajaxContext) {
	 			}
	 		});
	 	}
	}
	
	function commentSet(text) {
		response = text;
		
		$('.cmtWrite textarea').empty();
		
		var noUser = 'There is no user information.';
		var noProduct = 'There is no product information.';
		var noComment = 'There is no comment information.';
		
		if(response === noUser) {
			alert("로그인이 필요한 서비스 입니다.");
		} else if (response === noProduct) {
			alert("상품 정보를 확인할 수 없습니다.");
		} else if (response === noComment) {
			alert("입력할 코멘트가 없습니다.");
		} else {
			var commentAddElem = '<div class=\"cmtWrite\">';
			commentAddElem += '<textarea placeholder=\"댓글을 입력하세요\" class=\"cmtTextarea\" style=\"width: 580px; height: 50px;\"></textarea>';
			commentAddElem += '</div>';
			
			$('#comment_list').empty();
			$('#comment_list').html(response).contents();
			$('#comment_list').append(commentAddElem);
		}
		registerEvent();
	}
	
	
	function cmtReplyClick(e) {
		e.preventDefault();  
		$('.cmtReplyHide').css("display","none");
		$(this).parent('.functionCmt').next('.cmtReplyHide').css("display","block");
	}
	
	function afterVirtualOrder(text) { 
		response = text;
		var noUser = 'There is no user information.';
		var noAddress = "There is no user address information"; 
		
		if(response === noUser) {
			alert("로그인이 필요한 서비스 입니다.");
		} else if(response === noAddress) {
			alert("기본 주소를 등록해 주세요.");
		} else {
			response = $.parseJSON(response);
			var virtualOrderCount = response.virtualOrderCount;
			var strBasket = 'BASKET(' + virtualOrderCount + ')';
			$('#virtualOrderHeader').text(strBasket);
		}
		
		registerEvent(); 
	}
	
	function virtualOrder(e) {
		e.preventDefault();  
		
		var orderCount = $('#ord_goods_cnt').val();
		$.ajax({
			type : "POST",
			url : "virtualOrder",
			data : {
				"productId" : '${productDetail.product.productId}',
				"orderCount" : orderCount
			},
			success : afterVirtualOrder,
			error : function(ajaxContext) {
			}
		});
	}
	
	function afterDirectOrder(text) {
		response = text;
		var noUser = 'There is no user information.';
		var noAddress = "There is no user address information";

		if (response === noUser) {
			alert("로그인이 필요한 서비스 입니다.");
		} else if (response === noAddress) {
			alert("기본 주소를 등록해 주세요.");
		} else {
			var href = $('#directOrder').attr('href');
			location.href = href;
			return false;
		}

		registerEvent();
		return false;
	}
	
	function directOrder(e) {
		e.preventDefault();  
		
		var orderCount = $('#ord_goods_cnt').val();
		$.ajax({
			type : "POST",
			url : "directOrder",
			data : {
				"productId" : '${productDetail.product.productId}',
				"orderCount" : orderCount
			},
			success : afterDirectOrder,
			error : function(ajaxContext) {
			}
		});
	}

	function registerEvent() {
		$('#similar_item_list_prev').unbind('click').bind('click', pagePrev);
		$('#similar_item_list_next').unbind('click').bind('click', pageNext);
		$('.cmtWrite textarea').keyup(textAreaEnter);
		$('.cmtReply').unbind('click').bind('click', cmtReplyClick);
		$(".cmtReplyHide textarea").keyup(textAreaChildEnter);
		$("#ord_goods_cnt").change(function() {
			if ($(this).val() > '${productDetail.product.stock}') {
				$(this).val('${productDetail.product.stock}');
			} else if ($(this).val() <= 0) {
				$(this).val(1);
			}
		});

		$('#virtualOrder').unbind('click').bind('click', virtualOrder);
		$('#directOrder').unbind('click').bind('click', directOrder);
	}

	function pageSet(text) {
		response = text;
		response = $.parseJSON(response);

		$('.cmtReplyHide').css("display", "none");

		// Create Similar_Item_list
		//
		var trHTML = '';
		$.each(response.searchResults, function(i, item) {

			trHTML += '<li><p>' + '<a href=\"item/"'+ item.productName +'"\"><img src=\"/ShShopTest'+ item.imageUrl +'\" width=86 height=86></a>'
					+ '<strong><a href=\"/item/'+ item.productName +'\">' + item.productName + '</a></strong>' + '<span class=\"price\">'
					+ item.price + '</span></br>' + '<span class=\"time\">' + item.dataCreated + '</span>'
			'	</p></li>';
		});

		$('#similar_item_list').empty();
		$('#similar_item_list').append(trHTML);

		var totalPageCount = response.totalPageCount;
		var currentPage = response.currentPage;
		var endPage = response.endPage;

		var btnHtml = '';
		if (currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev\" class=\"movepreB\">이전 아이템</a>';
		}

		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>' + currentPage + '</strong>/' + totalPageCount;
		btnHtml += '</span>'

		if (currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next\" class=\"movenextB\">다음 아이템</a>';

		$('.moveBtn').empty();
		$('.moveBtn').append(btnHtml);

		registerEvent();
	}

	$(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "similarItemAction",
			data : {
				"productId" : '${productDetail.product.productId}',
				"data-page" : "1"
			},
			success : pageSet,
			error : function(ajaxContext) {
			}
		});
	});
</script>