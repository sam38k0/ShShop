<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/jquery-1.11.0.min.js"></script>
<script src="${adminBean.contextPath}/content/js/detail.js"></script>

<script type="text/javascript">


function pagePrev(event) {
	event.preventDefault();

	var keywords = $('#keywords').val();
	var currentPage = response.currentPage -1;

	$.ajax({
		type : "POST",
		url : "similarItemAction",
		data : {
			"productId" : '${sessionScope.productDetail.product.productId}',
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
			"productId" : '${sessionScope.productDetail.product.productId}',
			"data-page" : currentPage
		},
		success : pageSet,
		error : function(ajaxContext) {
		}
	});
	return false;
}

function pageSet(text) {
	response = text;
	response = $.parseJSON(response);
 
	// Create Similar_Item_list
	//
	var trHTML = '';
	$.each(response.searchResults, function(i, item) {
	 
		trHTML += '<li><p>' + 
				  '<a href=\"item/"'+ item.productName +'"\"><img src=\"/ShShopTest'+ item.imageUrl +'\" width=86 height=86></a>' +
				  '<strong><a href=\"/item/'+ item.productName +'\">' + item.productName + '</a></strong>' +
				  '<span class=\"price\">' + item.price + '</span></br>' +
				  '<span class=\"time\">'+ item.dataCreated +'</span>'
				  '	</p></li>';
	});
	
	$('#similar_item_list').empty();
	$('#similar_item_list').append(trHTML);
	
	var totalPageCount = response.totalPageCount;
	var currentPage = response.currentPage;
	var endPage = response.endPage;
	
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
	
	$("#comment_list").empty();
	if(response.commentResult != null && response.commentResult !== '')
		$("#comment_list").append(response.commentResult);
	
	$("#similar_item_list_prev").click(pagePrev);
	$("#similar_item_list_next").click(pageNext);
}

$(".cmtWrite textarea").keyup(function(e) {
	var code = (e.keyCode ? e.keyCode : e.which);
	if (code == 13) {
		$.ajax({
			type : "POST",
			url : "commentAddAction",
			data : {
				"productId" : '${sessionScope.productDetail.product.productId}',
			},
			success : commentSet,
			error : function(ajaxContext) {
			}
		});
	}
});

$(document).ready(function() {
	$.ajax({
		type : "POST",
		url : "similarItemAction",
		data : {
			"productId" : '${sessionScope.productDetail.product.productId}',
			"data-page" : "1"
		},
		success : pageSet,
		error : function(ajaxContext) {
		}
	});
});

</script>