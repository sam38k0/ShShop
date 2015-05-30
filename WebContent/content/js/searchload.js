$(document).ready(
		function() {
			$.ajax({
				type : "POST",
				url : "searchAction",
				datatype: "JSON",
				success : function(text) {
					response = text;
					response = $.parseJSON(response);

					var totalCount = response.totalSearchingCount;
					$('#itemListCount').append(totalCount);

					var trHTML = '';
					$.each(response.searchResults, function(i, item) {
						trHTML +=   '<tr>'+
									'<td><div id= \"'+ item.id +'\" class=\"outline\"><a href= \"#\"><img src= \"'+ item.imageUrl + 
									'\" width=\"90\" height=\"90\"></a></div></td>' + 
									'<td class=\"itemCnt\"><div class= \"itemInfo\"><p class=\"title\"><a href= \"#\">' + item.productName + '</a></p><p class=\"location\">' + 
									 item.location + '</p></div> </td>' +
									'<td class=\"price\">' + item.price + '</td>'+
									'<td class=\"safeOrder\">' + item.safeOrder + '</td>'+
									'<td class=\"user\">' + item.userName + '</td>'+
									'<td class=\"userLevel\">' + item.userLevel + '</td>'+
									'<td class=\"time\">' + item.dataCreated + '</td> '+
									'</tr>';
					});
					$('tbody').append(trHTML);
				},
			    error: function (ajaxContext) {
			        alert(ajaxContext.responseText)
			    }
			});
		});