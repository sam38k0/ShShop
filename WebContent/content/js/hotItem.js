$(document).ready(function() {
    var rows = $(".hot_item_area").find(".hot_item").length;
    var per_page = 16;
    var no_pages = Math.ceil(rows/per_page);
    
    var pageNumbers = $("<div id='hot_pages'></div>");
    for ( var i = 0;  i< no_pages; i++) {
        $("<span class='hot_page'>" + (i+1) + "</span>").appendTo(pageNumbers);
    }
    
    pageNumbers.insertAfter(".hot_item_area");
    
    $(".hot_page:first").css("background-color","#757575");
    
    $(".hot_page").hover(function() {
        $(this).addClass("content_hov");
    }, function() {
        $(this).removeClass("content_hov");
    });
    
    $(".hot_item_area").find(".hot_item").hide();
    
    var view = $(".hot_item");
    for ( var j = 0; j <= per_page - 1; j++) {
        $(view[j]).fadeIn('slow');
    }
    
    $(".hot_page").click(function(event) {
    	$(".hot_page").css("background-color","#c9c9c9");
    	$(this).css("background-color","#757575");
        $(".hot_item_area").find(".hot_item").hide();
        for ( var k = ($(this).text() - 1) * per_page; k <= $(this).text() * per_page - 1; k++) {
            $(view[k]).fadeIn('slow');
        }
    });
});