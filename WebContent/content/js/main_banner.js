$(document).ready(function() {
    var current = 0;
    var maxNum = $(".show_banner>li").length-1;
    //alert(maxNum);
    
    $("#nextBtn").bind('click',function() {
        if (current==maxNum) {
            current=0
        } else {
            current++
        }
        
        $(".show_banner>li").first().appendTo($(".show_banner"))
    })
    
    $("#prevBtn").bind('click',function() {
        if (current==maxNum) {
            current=2
        } else {
            current--
        }
        $(".show_banner>li").first().appendTo($(".show_banner"))
    })
});