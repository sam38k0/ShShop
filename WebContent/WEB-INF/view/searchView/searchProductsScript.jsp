<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script type="text/javascript">
function sorting(event) {
	event.preventDefault();
	var className = $(this).attr('class');
	if(className === 'on')
		return;
		
	$(this).addClass('on');
	$(this).siblings().removeClass('on');
 
	var keywords = $('#keywords').val();
	var dataPage = $('#currentPage').text();
	var sort = $(this).attr('sort');
	var priceFrom = $('#price_from').val();
	var priceTo = $('#price_to').val();

	$.ajax({
		type : "POST",
		url : "searchAction",
		data : {
			"categoryName" : '${param.categoryName}',
			"keywords" : keywords,
			"data-page" : dataPage,
			"sort" : sort,
			"price_from" : priceFrom,
			"price_to" : priceTo
		},
		success : pageSet,
		error : function(ajaxContext) {
		}
	});

	return;
}

function pageReset(event) {
	event.preventDefault();

	var keywords = $('#keywords').val();
	var dataPage = $(this).attr('data-page');
	var sort = $("ul.sortLeft li.on").attr("sort");
	var priceFrom = $('#price_from').val();
	var priceTo = $('#price_to').val();

	$.ajax({
		type : "POST",
		url : "searchAction",
		data : {
			"categoryName" : '${param.categoryName}',
			"keywords" : keywords,
			"data-page" : dataPage,
			"sort" : sort,
			"price_from" : priceFrom,
			"price_to" : priceTo
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

	// Set Total Row Count
	//
	var totalCount = response.totalSearchingCount;
	$('#itemListCount').empty();
	$('#itemListCount').append(totalCount);

	// Set Total Page Count
	//
	var totalPageCount = response.totalPageCount;
	$('#totalPageCount').empty();
	$('#totalPageCount').append(totalPageCount);

	// Set Total Size
	//
	var keywords = response.keywords;
	$('#keywords').val(keywords);
	$('#searchKeyWords').text(keywords);

	// Create Table Result Elements
	//
	var trHTML = '';
	$.each(response.searchResults, function(i, item) {
		trHTML += '<tr>' + '<td><div id= \"product_' + item.productId + '\" class=\"outline\"><a href= \"showDetailView?productId='+ item.productId+ '\"><img src= \"/ShShopTest' + item.imageUrl
				+ '\" width=\"90\" height=\"90\"></a></div></td>'
				+ '<td class=\"itemCnt\"><div class= \"itemInfo\"><p class=\"title\"><a href= \"showDetailView?productId='+ item.productId+ '\">' + item.productName
				+ '</a></p><p class=\"location\">' + item.location + '</p></div> </td>' + '<td class=\"price\">' + item.price + '</td>'
				+ '<td class=\"safeOrder\">' + item.safeOrder + '</td>' 
				+ '<td class=\"userName\">' + item.userName + '</td>'
				+ '<td class=\"hitCount\">' + item.hitCount + '</td>'
				+ '<td class=\"time\">' + item.dataCreated + '</td> ' + '</tr>';
	});
	$('tbody').empty();
	$('tbody').append(trHTML);

	// Create Paging Elements
	//
	var aHTML = '';
	var currentPage = response.currentPage;
	var startPage = parseInt(currentPage / 10) * 10 + 1;
	var endPage = startPage + 10;
	var arrowStart = startPage - 10;
	if (endPage > totalPageCount)
		endPage = totalPageCount;

	trHtML = '';
	if (currentPage > 10) {
		aHTML += '<a href=\"#\" class=\"arrow\" data-page=\"' + (startPage - 10) + '\">&lt;</a>';
	}
	for (var i = startPage; i < endPage; i++) {
		if (i != currentPage) {
			aHTML += '<a href=\"#\" data-page=\"' + i + '\">' + i + '</a>';
		} else {
			aHTML += '<span id=\"currentPage\">' + i + '</span>';
		}
	}
	if (totalPageCount > endPage)
		aHTML += '<a href="#" class="arrow" data-page=\"' + endPage + '\">&gt;</a>'

	$('#pagingSearchResults').empty();
	$('#pagingSearchResults').append(aHTML);

	$("#pagingSearchResults a").each(function(idx) {$(this).click(pageReset);});
	$('#btn_visible_search').click(pageReset);
	 
	$("#sortByDate").click(sorting);
	$("#sortByHit").click(sorting);
	$("#sortByHighPrice").click(sorting);
	$("#sortByLowPrice").click(sorting);
}

$(document).ready(function() {
	$.ajax({
		type : "POST",
		url : "searchAction",
		data : {
			"categoryName" : '${param.categoryName}',
			"keywords" : '${param.keywords}',
			"data-page" : "1",
			"sort" : "1",
			"price_from" : "0",
			"price_to" : "100000000"
		},
		success : pageSet,
		error : function(ajaxContext) {
		}
	});
});

</script>

