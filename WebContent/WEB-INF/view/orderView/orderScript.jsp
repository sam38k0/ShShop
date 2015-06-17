<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script type="text/javascript">

jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                                $(window).scrollLeft()) + "px");
    return this;
}

function fnLayerHideById(layerName)
{
    $('#' + layerName).css('display', 'none');
}

function fnLayerShowById(layerName)
{
    $('#' + layerName).css('display', 'block');
}

function pageInitialize(event) {
	fnLayerShowById('divPayMthdCard');
	fnLayerHideById('divPayMthdBankRTime');
	fnLayerHideById('divPayMthdBankAccnt');
	
	fnLayerShowById('ddlCardNormal');
	fnLayerHideById('ddlCardPartner');
	
	fnLayerHideById('divAddressList');
	fnLayerHideById('divAddressNew');
}

function openModalDialog(refLayerName, layerName, offsetTop) {
	var pos =  $('#' + refLayerName).position();
	var topPos = pos.top + offsetTop;
	$('#' + layerName).css('top',topPos); 
}

$(document).ready(function() {
	pageInitialize();

	$('input[type=radio][name=rdoPaymentMethod]').on('change', function(){
		$('input[type=radio][name=rdoPaymentMethod]').attr('checked','');
		
	    switch($(this).attr('id')){
	        case 'rdoCardNormal' : //신용카드 일반
	        	$(this).attr('checked','checked');
	        	$('#divPayMthdCard').css('display','block'); 
	        	fnLayerShowById('divPayMthdBankRTime');
	        	fnLayerHideById('divPayMthdBankAccnt');
	        	
	        	fnLayerShowById('ddlCardNormal');
	        	fnLayerHideById('ddlCardPartner');
	            break;
	            
	        case 'rdoCardPartner' ://제휴 할인카드
	        	$(this).attr('checked','checked');
	        	fnLayerShowById('divPayMthdCard');
	        	fnLayerHideById('divPayMthdBankRTime');
	        	fnLayerHideById('divPayMthdBankAccnt');
	        	fnLayerHideById('ddlCardNormal');
	        	fnLayerShowById('ddlCardPartner');
	            break;
	            
	        case 'rdoAccountTransfer' : //계좌이체
	        	$(this).attr('checked','checked'); 
	        	fnLayerHideById('divPayMthdCard');
	        	fnLayerShowById('divPayMthdBankRTime');
	        	fnLayerHideById('divPayMthdBankAccnt');
	        	break;
	        	
	        case 'rdoDeposit' :// 무통장 입금
	        	$(this).attr('checked','checked');
	        	fnLayerHideById('divPayMthdCard');
	        	fnLayerHideById('divPayMthdBankRTime');
	        	fnLayerShowById('divPayMthdBankAccnt');
	        	break;
	    }            
	});
	
	$('input[type=radio][name=rdoDelvAddrSetMod]').on('change', function(){
	    switch($(this).attr('id')){
        case 'rdoDelvAddrSetModeMember' : //회원정보 동일
        	$(this).attr('checked','checked');
        	fnLayerHideById('newAddressSettings'); 
        	fnLayerShowById('basicAddressSettings');
        	fnLayerHideById('divAddressList');
            break;
            
        case 'rdoDelvAddrSetModeList' ://주소록
        	$(this).attr('checked','checked');
        	openModalDialog('rdoDelvAddrSetModeList','divAddressList', 200);
        	fnLayerShowById('divAddressList');
            break;
            
        case 'rdoDelvAddrSetModeNew' : //새로입력
        	$(this).attr('checked','checked'); 
        	fnLayerShowById('newAddressSettings');
        	fnLayerHideById('basicAddressSettings');
        	fnLayerHideById('divAddressList');
        	break;
    	}   
	});
});

</script>