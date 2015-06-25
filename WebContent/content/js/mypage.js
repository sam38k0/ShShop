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
	
	/* 판매거래 셀렉트 */
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
	
	/* 구매거래 셀렉트 */
	var $selllayer = $(".sell_SelectText");
	var $sellcurrent = $(".sell_boxUI");
	var $sellcurli = $(".sell_boxUI li");
	
	$selllayer.on('click',function() {
		$sellcurrent.slideToggle("fast");
	});
	
	if ($sellcurrent) {
		if(!$sellcurli.hasClass("sell_selects"))
			$sellcurli.first().addClass("sell_selects");
		
		$sellcurli.click(function(e) {
			var inx = parseInt($(this).index()) +1;
			
			$('.sell_SelectText').text($(this).text());
			
			$(e.currentTarget).addClass("sell_selects").siblings().removeClass("sell_selects");
			$sellcurrent.hide();
		});
	}
	
	/* 거래 정보 */
	$(".deal_info").click(function() {
		$("#user_wrap").hide();
		$(".buy_table").hide();
		$(".board_table").hide();
		$("#deal_wrap").show();
		$(".sell_table").show();
	});
	
	/* 개인 정보 */
	$(".user_info").click(function() {
		$("#deal_wrap").hide();
		$("#user_wrap").show();
	});
	
	/* 판매 거래 리스트 
	$("#sell_list a").click(function() {
		$("#buy_table").hide();
		$("#board_table").hide();
		$("#sell_table").show();
	});
	
	 구매 거래 리스트 
	$("#buy_list a").click(function() {
		$("#sell_table").hide();
		$("#board_table").hide();
		$("#buy_table").show();
	});
	*/
	 /* 판매 게시물 리스트 */ 
	$("#sell_board_list a").click(function() {
		$('.sell_table').hide();
		$('.buy_table').hide();
		$(".board_table").show();
	});
	
	
});