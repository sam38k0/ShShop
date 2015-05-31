function pageSet(text) {
	response = text;
	response = $.parseJSON(response);

	// Total Row Count
	var totalCount = response.totalSearchingCount;
	$('#itemListCount').empty();
	$('#itemListCount').append(totalCount);

	// Total Page Count
	var totalPageCount = response.totalPageCount;
	$('#totalPageCount').empty();
	$('#totalPageCount').append(totalPageCount);

	// Total Size
	var keywords = response.keywords;
	$('#keywords').val(keywords);
	$('#searchKeyWords').text(keywords);

	// Table Result
	var trHTML = '';
	$.each(response.searchResults, function(i, item) {
		trHTML += '<tr>' + '<td><div id= \"' + item.id + '\" class=\"outline\"><a href= \"#\"><img src= \"' + item.imageUrl
				+ '\" width=\"90\" height=\"90\"></a></div></td>'
				+ '<td class=\"itemCnt\"><div class= \"itemInfo\"><p class=\"title\"><a href= \"#\">' + item.productName
				+ '</a></p><p class=\"location\">' + item.location + '</p></div> </td>' + '<td class=\"price\">' + item.price + '</td>'
				+ '<td class=\"safeOrder\">' + item.safeOrder + '</td>' + '<td class=\"user\">' + item.userName + '</td>'
				+ '<td class=\"userLevel\">' + item.userLevel + '</td>' + '<td class=\"time\">' + item.dataCreated + '</td> ' + '</tr>';
	});
	$('tbody').empty();
	$('tbody').append(trHTML);

	// Paging
	var aHTML = '';
	var currentPage = response.currentPage;
	var startPage = parseInt(currentPage / 10) * 10 + 1;
	var endPage = startPage + 10;
	var arrowStart = startPage -10;
	if (endPage > totalPageCount)
		endPage = totalPageCount;

	trHtML = '';
	if (currentPage > 10) {
		aHTML += '<a href=\"#\" class=\"arrow\" data-page=\"' + (startPage-10) + '\">&lt;</a>';
	}
	for (var i = startPage; i < endPage; i++) {
		if (i != currentPage) {
			aHTML += '<a href=\"#\" data-page=\"' + i + '\">' + i + '</a>';
		} else {
			aHTML += '<span>' + i + '</span>';
		}
	}
	if (totalPageCount > endPage)
		aHTML += '<a href="#" class="arrow" data-page=\"' + endPage + '\">&gt;</a>'

	$('#pagingSearchResults').empty();
	$('#pagingSearchResults').append(aHTML);

	$("#pagingSearchResults a").each(function(idx) {
		$(this).click(function(event) {
			event.preventDefault();
			
			var keywords = $('#keywords').val();
			var dataPage = $(this).attr('data-page');
			
			$.ajax({
				type : "POST",
				url : "searchAction",
				data : {
					"keywords": keywords,
					"data-page": dataPage
				},
				success : pageSet,
				error : function(ajaxContext) {
				}
			});
			return false;
		});
	});
}

$(document).ready(
function() {
	$.ajax({
		type : "POST",
		url : "searchAction",
		success : pageSet,
		error : function(ajaxContext) {
			alert(ajaxContext.responseText)
		}
	});
});
