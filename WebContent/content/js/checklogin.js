$(document).ready(function()
{
	$.ajax({ 
		type: "POST",
		url: "ajax/checklogin", 
        success: function (text) {
        	response = text;
            if (response === 'onLogin') {
            	$(".gnb_before_login").hide();
            	$(".gnb_after_login").show();
            }
            else {
            	$(".gnb_before_login").show();
            	$(".gnb_after_login").hide();
            }
	     }});
});