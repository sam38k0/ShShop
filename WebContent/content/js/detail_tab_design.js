jQuery(function($) {

	$('#tab_design').tabs({
		start_index: 2,
		random: true,
		transition_time: 200
	});
			
	if($.browser.msie && $.browser.version < 10) {
		$.getScript('include/js/libs/PIE.min.js', function() {
			var target = $.browser.version <= 6 ? '.tab_contents' : '.tab_menu a, .tab_contents';
			$(target).each(function() { PIE.attach(this); });
		});
	};
	
});

