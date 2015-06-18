$(document).ready(function() {
    var current = 0;
    var maxNum = $(".show_banner>li").length-1;
    
    $("#nextBtn").bind('click',function() {
        if (current==maxNum) {
            current=0
        } else {
            current++
        }
        
        $(".show_banner>li").removeClass("on")
        $(".show_banner>li").eq(current).addClass("on")
        
        $(".show_banner>li").fadeOut('slow')
        $(".show_banner>li.on").fadeIn('slow')
    })
    
    $("#prevBtn").bind('click',function() {
        if (current<=0) {
            current=3
        } else {
            current--
        }
        
        $(".show_banner>li").removeClass("on")
        $(".show_banner>li").eq(current).addClass("on")
        
        $(".show_banner>li").fadeOut('slow')
        $(".show_banner>li.on").fadeIn('slow')
    })
});