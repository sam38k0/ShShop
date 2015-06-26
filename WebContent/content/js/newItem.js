$(document).ready(function() {
                var rows = $(".new_item_area").find(".new_item").length;
                //alert(rows);
                var per_page = 16;
                var no_pages = Math.ceil(rows/per_page);
                //alert(no_pages)

                var pageNumbers = $("<div id='new_pages'></div>");
                for ( var i = 0;  i< no_pages; i++) {
                    $("<span class='new_page'>" + (i+1) + "</span>").appendTo(pageNumbers);
                }

                pageNumbers.insertAfter(".new_item_area");
                
                $(".new_page:first").css("background-color","#757575");
                
                $(".new_page").hover(function() {
                    $(this).addClass("content_hov");
                }, function() {
                    $(this).removeClass("content_hov");
                });
                
                $(".new_item_area").find(".new_item").hide();
                
                var view = $(".new_item");
                for ( var j = 0; j <= per_page - 1; j++) {
                    $(view[j]).fadeIn('slow');
                }
                
                $(".new_page").click(function(event) {
                	$(".new_page").css("background-color","#c9c9c9");
                	$(this).css("background-color","#757575");
                    $(".new_item_area").find(".new_item").hide();
                    for ( var k = ($(this).text() - 1) * per_page; k <= $(this).text() * per_page - 1; k++) {
                        $(view[k]).fadeIn('slow');
                    }
                });
            });