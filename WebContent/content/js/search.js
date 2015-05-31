$(document).ready(

		function() {
			 /*
            $( '.aClickPage' ).click(function (event){ 
            	event.preventDefault(); 
            	 
                $.ajax({ 
    				type : "POST",
    				url : "searchAction",
                    data: { 
                        "keywords": $('#keywords').val(keywords),
                        "data-page": $(this).attr('data-page')
                    },
                    success: function (text) { 
                        $( '#name').val(data.name); 
                        $( '#email').val(data.email); 
                    } 
                }); 
            }); 
*/
			$.ajax({
				type : "POST",
				url : "searchAction",
				success : function(text) {
					response = text;
					response = $.parseJSON(response);

					//Total Row Count
					var totalCount = response.totalSearchingCount;
					$('#itemListCount').append(totalCount);

					//Total Page Count
					var totalPageCount = response.totalPageCount;
					$('#totalPageCount').append(totalPageCount);

					// Total Size
					var keywords = response.keywords;
					$('#keywords').val(keywords);
					$('#searchKeyWords').text(keywords);
					
					//Table Result
					var trHTML = '';
					$.each(response.searchResults, function(i, item) {
						trHTML += '<tr>' + '<td><div id= \"' + item.id + '\" class=\"outline\"><a href= \"#\"><img src= \"' + item.imageUrl
								+ '\" width=\"90\" height=\"90\"></a></div></td>'
								+ '<td class=\"itemCnt\"><div class= \"itemInfo\"><p class=\"title\"><a href= \"#\">' + item.productName
								+ '</a></p><p class=\"location\">' + item.location + '</p></div> </td>' + '<td class=\"price\">' + item.price
								+ '</td>' + '<td class=\"safeOrder\">' + item.safeOrder + '</td>' + '<td class=\"user\">' + item.userName + '</td>'
								+ '<td class=\"userLevel\">' + item.userLevel + '</td>' + '<td class=\"time\">' + item.dataCreated + '</td> '
								+ '</tr>';
					});
					$('tbody').append(trHTML);
					
					//Paging
					var aHTML = '';
					var currentPage = response.currentPage;
					var startPage =  (currentPage/10)*10;
					var endPage = startPage + 11;
					if(endPage > totalPageCount)
						endPage = totalPageCount;

					trHtML = '';
					if (currentPage > 10) {
						aHTML += '<a href=\"searchView\" class=\"arrow\" data-page=\"' + startPage + '\">&lt;</a>';
					}
					for (var i = startPage; i < endPage; i++) {
						if (i != currentPage) {
							aHTML += '<a href=\"searchView\" class=\"aClickPage\" data-page=\"' + i + '\">' + i + '</a>';
						} else {
							aHTML += '<span>' + i + '</span>';
						}
					}
					if ( totalPageCount > endPage) {
						aHTML += '<a href="searchView" class="arrow" data-page=\"' + endPage + '\">&gt;</a>'
					}
					
					$('#pagingSearchResults').append(aHTML);
				},
				error : function(ajaxContext) {
					alert(ajaxContext.responseText)
				}
			});
		});