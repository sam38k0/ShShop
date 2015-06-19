$(document).ready(function() {
	$("#user_form").submit(function() {
        var form = $(this);
        
        if ($("#password_main").val() == "") {
        	alert("비밀번호를 입력해주세요.");
        	$("#password_main").focus();
        } else if ($("#password_check").val() == "") {
        	alert("비밀번호 확인을 입력해주세요");
        	$("#password_check").focus();
        } else if ($("#password_main").val() != $("#password_check").val()) {
        	alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        	$("#password_main").val("");
        	$("#password_check").val("");
        	$("#password_main").focus();
        }
        
        $.ajax({
            url: "userUpdate",
            data : form.serialize(),
            type: "post",
            dataType : "text",
            success: function(data) {
              alert(data);
              console.log("정보 수정 완료");
            },
	        fail: function() {
	    		alert("다시 시도해 주세요");
	    	}
        });
    });
	
	var $layer = $(".deal_SelectText");
	var $current = $(".deal_boxUI");
	var $curli = $(".deal_boxUI li");
	
	$layer.on('click',function() {
		$current.slideToggle("fast");
	});
	
	if ($current) {
		if(!$curli.hasClass("deal_selects"))
			$curli.first().addClass("deal_selects");
		
		$curli.click(function(e) {
			var inx = parseInt($(this).index()) +1;
			
			$('.deal_SelectText').text($(this).text());
			
			$(e.currentTarget).addClass("deal_selects").siblings().removeClass("deal_selects");
			$current.hide();
		});
	}
	
	
});