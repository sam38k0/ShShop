<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script type="text/javascript">

function pageInitialize(event) {
	$('#divPayMthdCard').css('display','block'); 
	$('#divPayMthdBankRTime').css('display','none');
	$('#divPayMthdBankAccnt').css('display','none');

	$('#ddlCardNormal').css('display','block');
	$('#ddlCardPartner').css('display','none');
	
	$('#divAddressList').css('display','none'); 
}

$(document).ready(function() {
	pageInitialize();

	$('input[type=radio][name=rdoPaymentMethod]').on('change', function(){
		$('input[type=radio][name=rdoPaymentMethod]').attr('checked','');
		
	    switch($(this).attr('id')){
	        case 'rdoCardNormal' : //신용카드 일반
	        	$(this).attr('checked','checked');
	        	$('#divPayMthdCard').css('display','block'); 
	        	$('#divPayMthdBankRTime').css('display','none');
	        	$('#divPayMthdBankAccnt').css('display','none');
	        	
	        	$('#ddlCardNormal').css('display','block');
	        	$('#ddlCardPartner').css('display','none');
	            break;
	            
	        case 'rdoCardPartner' ://제휴 할인카드
	        	$(this).attr('checked','checked');
	        	$('#divPayMthdCard').css('display','block'); 
	        	$('#divPayMthdBankRTime').css('display','none');
	        	$('#divPayMthdBankAccnt').css('display','none');
	        	
	        	$('#ddlCardNormal').css('display','none');
	        	$('#ddlCardPartner').css('display','block');
	            break;
	            
	        case 'rdoAccountTransfer' : //계좌이체
	        	$(this).attr('checked','checked'); 
	        	$('#divPayMthdCard').css('display','none'); 
	        	$('#divPayMthdBankRTime').css('display','block');
	        	$('#divPayMthdBankAccnt').css('display','none');
	        	break;
	        	
	        case 'rdoDeposit' :// 무통장 입금
	        	$(this).attr('checked','checked');
	        	$('#divPayMthdCard').css('display','none'); 
	        	$('#divPayMthdBankRTime').css('display','none');
	        	$('#divPayMthdBankAccnt').css('display','block');
	        	break;
	    }            
	});
	
	$('input[type=radio][name=rdoDelvAddrSetMod]').on('change', function(){
	    switch($(this).attr('id')){
        case 'rdoDelvAddrSetModeMember' : //회원정보 동일
        	$(this).attr('checked','checked');
        	$('#newAddressSettings').css('display','none'); 
        	$('#basicAddressSettings').css('display','block'); 
        	$('#divAddressList').css('display','none'); 
            break;
            
        case 'rdoDelvAddrSetModeList' ://주소록
        	$(this).attr('checked','checked');
        	$('#divAddressList').css('display','block'); 
            break;
            
        case 'rdoDelvAddrSetModeNew' : //새로입력
        	$(this).attr('checked','checked'); 
        	$('#newAddressSettings').css('display','block'); 
        	$('#basicAddressSettings').css('display','none'); 
        	$('#divAddressList').css('display','none'); 
        	break;
    	}   
	});
	
	
});

</script>