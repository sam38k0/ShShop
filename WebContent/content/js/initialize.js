$(document).ready(function()
{
	$("#m_join").hide();
	$("#m_login").hide();
	
	$.ajax({ 
		type: "POST",
		url: "checklogin", 
        success: function (text) {
        	response = text;
            if (response === 'onLogin') {
            	$(".gnb_before_login").hide();
            	$(".gnb_after_login").show();
            	$("#link").show();
            }
            else {
            	$(".gnb_before_login").show();
            	$(".gnb_after_login").hide();
            	$("#link").hide();
            }
	     }});
});