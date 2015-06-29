$(function() {
	var $layer = $(".divSelectText");
	var $current = $(".selectboxUI");
	var $curli = $(".selectboxUI li");
	
	$layer.on('click',function() {
		$current.slideToggle("fast");
	});
	
	if ($current) {
		if(!$curli.hasClass("selected"))
			$curli.first().addClass("selected");
		
		$curli.click(function(e) {
			var inx = parseInt($(this).index()) +1;
			
			$('.divSelectText').text($(this).text());
			
			$(e.currentTarget).addClass("selected").siblings().removeClass("selected");
			$current.hide();
		});
	}
	
	// 헤더 카테고리
	$("#category>ul>li>ul>li>ul").wrap("<div></div>");
	
	$("#category>ul>li>ul>li").bind('click',function() {
		
		if ($(this).children().next().css("display")=="block") {
			$(this).children().next().slideUp("1000");
		} else {
			var showList=$(this).index();
			$("#category>ul>li>ul>li>div").slideUp("1000");
			$(this).children().next().slideDown("1000");
		}
	});
});