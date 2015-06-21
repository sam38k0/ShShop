<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script src="${adminBean.contextPath}/content/js/common.js"></script>

<script type="text/javascript">

	function fnLayerHideById(layerName) {
	    $('#' + layerName).css('display', 'none');
	}
	
	function fnLayerShowById(layerName) {
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
	
	function openModalDialog(layerName, offsetTop) {
 
		var $window = $(window);
		var outerHeight = $('#' + layerName).outerHeight();
		var outerWidth = $('#' + layerName).outerWidth();
		
		var topPos = Math.max($window.height() - outerHeight, 0) / 2;
		var leftPos = Math.max($window.width() - outerWidth, 0) / 2;

		$('#' + layerName).css({
			//top : topPos + $window.scrollTop() + offsetTop,
			top : offsetTop,
			left : leftPos + $window.scrollLeft()
		}); 
		
		fnLayerShowById(layerName);
	}
	 
	function fnChangeUrlOfAddrChooser(checkedId) {
		var indx = checkedId.replace('#chkMemberAddress', ''); 
		$('#addrChooser').attr("value", indx); 
		
	}
	
	function fnResetAddrChooser(checkBoxName) { 
		$('#addrChooser').attr("value", '');
		$('input:checkbox[name="' + checkBoxName + '"]').attr('checked', false);
	}

	function fnCheckedChangeHeader(checkBoxName, checkBoxHeaderId) {
		var id = "#" + checkBoxHeaderId;
		
		var isChecked = $("#" + checkBoxHeaderId).is(":checked");
		$('input:checkbox[name="' + checkBoxName + '"]').attr('checked', false);
		if (isChecked === true) {
			$(id).prop('checked', true);
			fnChangeUrlOfAddrChooser(id);
		} else {
			$(id).prop('checked', false);
			fnResetAddrChooser(checkBoxName);
		}
	}
	
    function setPostCode(postCodeHeadId, postCodeTailId,roadId,jibunId ) {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullAddrRoad = ''; 
                var fullAddrJibun = ''; 
                var extraAddr = '';

                fullAddrRoad = data.roadAddress;
                fullAddrJibun = data.jibunAddress; 

                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddrJibun += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                document.getElementById(postCodeHeadId).value = data.postcode1;
                document.getElementById(postCodeTailId).value = data.postcode2;
                document.getElementById(roadId).value = fullAddrRoad;
                document.getElementById(jibunId).value = fullAddrJibun;
            }
        }).open();
    }
    
    function addAddressInfo(index, addrname, username, postHead, postTail, fullAddr, fullAddrNew, phoneNumber) {
    	var result = "\
    	    <tr id=\"addressInfoItem$INDX$\">\
            <td valign=\"top\">\
                <input type=\"checkbox\" id=\"chkMemberAddress$INDX$\" name=\"chkMemberAddress\" value=\"$INDX$\" class=\"chkbx\">\
            </td>\
            <td valign=\"top\">\
                <a href=\"#\" id=\"memberAddressName$INDX$\">$ADDRNAME$</a>\
            </td>\
            <td valign=\"top\">\
                $USERNAME$\
            </td>\
            <td class=\"le\" valign=\"top\">\
                <div class=\"putAddrWrap\">\
                    <div class=\"putAddrLft\">\
                        <img class=\"addr_item\" src=\"https://secimage.yes24.com/sysimage/orderN/btn_putAddr02.gif\" width=\"30\" height=\"13\" alt=\"도로명\">\
                    </div>\
                    <div class=\"putAddrRgt\">\
                        <span class=\"putAddrTxt\"><a href=\"#\" id=\"memberZipCodeNew$INDX$\">($POSTHEAD$-$POSTTAIL$)$FULLADDRNEW$</a></span>\
                    </div>\
                </div>\
                <div class=\"putAddrWrap mgt5\">\
                    <div class=\"putAddrLft\">\
                        <img class=\"addr_item\" src=\"https://secimage.yes24.com/sysimage/orderN/btn_putAddr03.gif\" width=\"30\" height=\"13\" alt=\"지번\">\
                    </div>\
                    <div class=\"putAddrRgt\">\
                        <span class=\"putAddrTxt grayTxt\">\
    					    <a class=\"grayTxt\" href=\"#\" id=\"memberZipCode$INDX$\">($POSTHEAD$-$POSTTAIL$)$FULLADDR$</a></span>\
                    </div>\
                </div>\
            </td>\
            <td valign=\"top\" id=\"memberPhoneNumber$INDX$\">$PHONE$</td>\
            <td valign=\"top\">\
                <a href=\"#\" id=\"addressDelete$INDX$\" title=\"삭제하기\" class=\"bw delet_s\">삭제하기</a>\
                <a href=\"#\" id=\"addressModify$INDX$\" title=\"수정\" class=\"bw modif\">수정</a>\
            </td>\
        </tr>";
    				 
        result = result.split('$INDX$').join(index);
        result = result.split('$USERNAME$').join(username);
        result = result.split('$ADDRNAME$').join(addrname);
        result = result.split('$POSTHEAD$').join(postHead);
        result = result.split('$POSTTAIL$').join(postTail);
        result = result.split('$FULLADDRNEW$').join(fullAddrNew);
        result = result.split('$FULLADDR$').join(fullAddr);
        result = result.split('$PHONE$').join(phoneNumber);
        
    	return result;
    }
    
    function makePhoneSelectHtml(phoneNumberHead) { 

		var arrPhoneHeaders = ["<option value=\"010\">010</option>", 
		                       "<option value=\"011\">011</option>",
							   "<option value=\"016\">016</option>", 
						 	   "<option value=\"017\">017</option>", 
						 	   "<option value=\"018\">018</option>",
						 	   "<option value=\"019\">019</option>"];

		switch (phoneNumberHead) {
		case "011":
			arrPhoneHeaders[1] = "<option value=\"011\" selected=\"selected\">011</option>";
			break;

		case "016":
			arrPhoneHeaders[2] = "<option value=\"016\" selected=\"selected\">016</option>";
			break;

		case "017":
			arrPhoneHeaders[3] = "<option value=\"017\" selected=\"selected\">017</option>";
			break;

		case "018":
			arrPhoneHeaders[4] = "<option value=\"018\" selected=\"selected\">018</option>";
			break;

		default:
			arrPhoneHeaders[0] = "<option value=\"010\" selected=\"selected\">010</option>";
		}
		
		return arrPhoneHeaders.join('');
    }
    
	function changeAddressData(text) {
		response = text;
		response = $.parseJSON(response);
		
		var indx = response.addrIndex;
		var name = response.addressName;
		var phoneNumber = response.addressPhoneNumber;
		var zipHead = response.addrPostNumHeader;
		var zipTail = response.addrPostNumTail;
		var basicAdd = response.addrBasicAdd;
		var basicAddNew = response.addrNewBasicAdd;
		var detailAdd = response.addrDetailAdd;
		var phoneHead = response.addressPhoneNumberHead;
		var phoneMid = response.addressPhoneNumberMid;
		var phoneTail = response.addressPhoneNumberTail;
		var phoneHtml = makePhoneSelectHtml(phoneHead);
		
		//주소록 내부 데이터 수정
		$('#memberAddressName' + indx).text("" + name);
		$('#memberZipCode' + indx).text("(" + zipHead + "-" + zipTail +")" + basicAdd + " " + detailAdd);
		$('#memberZipCodeNew' + indx).text("(" + zipHead + "-" + zipTail +")" + basicAddNew + " " + detailAdd);
		$('#memberPhoneNumber' + indx).val(phoneNumber);
		
		if(indx == '0') { //기본 주소도 바꿈
			$('#txtZipCode1Basic').val(zipHead);
			$('#txtZipCode2Basic').val(zipTail);
			$('#txtAddressByStBasic').val(basicAddNew);
			$('#txtAddressByOldBasic').val(basicAdd);
			$('#txtAddressDetail').val(detailAdd);
            $('#ddlRcvrMobTelNo1NormalBasic').html(phoneHtml);
            $('#txtRcvrMobTelNo2NormalNew').val(phoneMid);
            $('#txtRcvrMobTelNo3NormalNew').val(phoneTail);
		}
		
		fnLayerHideById('divAddressNew' + indx);
		openModalDialog('divAddressList', 500);
		fnAjaxLoaderLayerHide("divAjaxLoader");
		registerEvent();
	}
	
	function addAddressData(text) {
		response = text;
		response = $.parseJSON(response);
		
		var indx = response.addrIndex;
		var userName = response.userName;
		var addrName = response.addressName;
		var phoneNumber = response.addressPhoneNumber;
		var zipHead = response.addrPostNumHeader;
		var zipTail = response.addrPostNumTail;
		var basicAdd = response.addrBasicAdd;
		var basicAddNew = response.addrNewBasicAdd;
		var detailAdd = response.addrDetailAdd;
		
		var appendText = addAddressInfo(indx, addrName, userName, zipHead, zipTail, basicAdd + detailAdd, basicAddNew + detailAdd);
		$("#addressInfoTable").append(appendText);
		fnAjaxLoaderLayerHide("divAjaxLoader");
		registerEvent();
	}
	
	function deleteAddressData(text) {
		response = text;
		response = $.parseJSON(response);
		var indx = response.addrIndex;
		$('#addressInfoItem' + indx).empty();
		fnAjaxLoaderLayerHide("divAjaxLoader");
		registerEvent();
	}
	
	function registerEvent() {

		$('input[type=radio][name=rdoPaymentMethod]').on('change', function() {
			$('input[type=radio][name=rdoPaymentMethod]').attr('checked', '');

			switch ($(this).attr('id')) {
			case 'rdoCardNormal': //신용카드 일반
				$(this).attr('checked', 'checked');
				$('#divPayMthdCard').css('display', 'block');
				fnLayerShowById('divPayMthdBankRTime');
				fnLayerHideById('divPayMthdBankAccnt');

				fnLayerShowById('ddlCardNormal');
				fnLayerHideById('ddlCardPartner');
				break;

			case 'rdoCardPartner'://제휴 할인카드
				$(this).attr('checked', 'checked');
				fnLayerShowById('divPayMthdCard');
				fnLayerHideById('divPayMthdBankRTime');
				fnLayerHideById('divPayMthdBankAccnt');
				fnLayerHideById('ddlCardNormal');
				fnLayerShowById('ddlCardPartner');
				break;

			case 'rdoAccountTransfer': //계좌이체
				$(this).attr('checked', 'checked');
				fnLayerHideById('divPayMthdCard');
				fnLayerShowById('divPayMthdBankRTime');
				fnLayerHideById('divPayMthdBankAccnt');
				break;

			case 'rdoDeposit':// 무통장 입금
				$(this).attr('checked', 'checked');
				fnLayerHideById('divPayMthdCard');
				fnLayerHideById('divPayMthdBankRTime');
				fnLayerShowById('divPayMthdBankAccnt');
				break;
			}
		});

		$('input[type=radio][name=rdoDelvAddrSetMod]').on('change', function() {
			switch ($(this).attr('id')) {
			case 'rdoDelvAddrSetModeMember': //회원정보 동일
				$(this).attr('checked', 'checked');
				fnLayerHideById('newAddressSettings');
				fnLayerShowById('basicAddressSettings');
				fnLayerHideById('divAddressList');
				for(var i = 0; i < 5; i++)
					fnLayerHideById('existingAddressSettings' + i);
				break;

			case 'rdoDelvAddrSetModeList'://주소록
				$(this).attr('checked', 'checked');
				openModalDialog('divAddressList', 500);
				break;

			case 'rdoDelvAddrSetModeNew': //새로입력
		    	$('#txtOrdNmNormalNew').val(''); 
		    	$('#txtZipCode1New').val(''); 
		    	$('#txtZipCode2New').val(''); 
		    	$('#txtAddressByStNew').val(''); 
		    	$('#txtAddressByOldNew').val(''); 
		    	$('#txtAddressNewDetail').val('');
		    	$('#ddlRcvrMobTelNo1NormalNew').val('');
		    	$('#txtRcvrMobTelNo2NormalNew').val('');
		    	$('#txtRcvrMobTelNo3NormalNew').val('');
	 
				$(this).attr('checked', 'checked');
				fnLayerShowById('newAddressSettings');
				fnLayerHideById('basicAddressSettings');
				fnLayerHideById('divAddressList');
				for(var i = 0; i < 5; i++)
					fnLayerHideById('existingAddressSettings' + i);
				break;
			}
		});

		$('.chkbx').change(function() {
			var id = $(this).attr('id');
			var name = $(this).attr("name");
			fnCheckedChangeHeader(name, id);
		});

		$('#addrChooser').click(function(event) {
			event.preventDefault();
			
			var addrIndex = $(this).attr('value');
			if(addrIndex == null || addrIndex=='') {
				alert('주소를 선택하세요.');
				return;
			}
			
			fnLayerHideById('newAddressSettings');
			fnLayerHideById('basicAddressSettings');
			fnLayerHideById('divAddressList');
			fnLayerShowById('existingAddressSettings' + addrIndex);
		});
		
	    $("#aZipFind").click(function() {
	    	setPostCode('txtZipCode1New','txtZipCode2New','txtAddressByStNew','txtAddressByOldNew');
	    });
 
	    $('.modif').click(function(){
	    	var id = $(this).attr('id');
	    	
	    	var indx = id.replace('addressModify', '');
	    	var addressNewId = 'divAddressNew' + indx;
	    	fnLayerHideById('divAddressList');
	    	openModalDialog(addressNewId, 500);
	    });
	    
	    $('.sch_address').click(function(){
	    	var id = $(this).attr('id');
	    	var indx = id.replace('aZipFinderSub', '');
	    	setPostCode('txtZipCd1New'+ indx,'txtZipCd2New'+ indx,'txtAddressNewBySt'+ indx,'txtAddressNewByOld'+ indx);
	    });
	    
	    $('.cfrm').click(function(){
	    	var id = $(this).attr('id');
	    	
	    	var indx = id.replace('btnAddrModify', '');
	    	
	    	var addrName = $('#txtAddrNickNew' + indx).val(); 
	    	var addrZipCodeHead = $('#txtZipCd1New' + indx).val(); 
	    	var addrZipCodeTail = $('#txtZipCd2New' + indx).val(); 
	    	var addrBasicNew = $('#txtAddressNewBySt' + indx).val(); 
	    	var addrBasicOld = $('#txtAddressNewByOld' + indx).val(); 
	    	var addrDetail = $('#txtAddressDetail' + indx).val();
	    	var addrPhoneNumber = $('#txtMobNoNew' + indx).val();

			$.ajax({
				type : 'POST',
				url : 'changeOrderAddr',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'addressIndex' : indx,
					'addrName' : addrName,
					'addrZipCodeHead' : addrZipCodeHead,
					'addrZipCodeTail' : addrZipCodeTail,
					'addrBasicNew' : addrBasicNew,
					'addrBasicOld' : addrBasicOld,
					'addrDetail' : addrDetail,
					'addrPhoneNumber' : addrPhoneNumber
				},
				success : changeAddressData,
				error : function(ajaxContext) {
					alert("변경된 주소를 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					registerEvent();
				}
			});
	    });
	    
	    $('#addNewAddress').click(function(){
	    	var addrName = $('#txtOrdNmNormalNew').val(); 
	    	var addrZipCodeHead = $('#txtZipCode1New').val(); 
	    	var addrZipCodeTail = $('#txtZipCode2New').val(); 
	    	var addrBasicNew = $('#txtAddressByStNew').val(); 
	    	var addrBasicOld = $('#txtAddressByOldNew').val(); 
	    	var addrDetail = $('#txtAddressNewDetail').val();
	    	var addrPhoneHead = $('#ddlRcvrMobTelNo1NormalNew').val();
	    	var addrPhoneMid = $('#txtRcvrMobTelNo2NormalNew').val();
	    	var addrPhoneTail = $('#txtRcvrMobTelNo3NormalNew').val();
			var addrPhoneNumber = addrPhoneHead + "-" + addrPhoneMid + "-" + addrPhoneTail;
			
			$.ajax({
				type : 'POST',
				url : 'addAddress',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'addrName' : addrName,
					'addrZipCodeHead' : addrZipCodeHead,
					'addrZipCodeTail' : addrZipCodeTail,
					'addrBasicNew' : addrBasicNew,
					'addrBasicOld' : addrBasicOld,
					'addrDetail' : addrDetail,
					'addrPhoneNumber' : addrPhoneNumber
				},
				success : addAddressData,
				error : function(ajaxContext) {
					alert("변경된 주소를 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					registerEvent();
				}
			});
	    });
	    
	    $('.delet_s').click(function(){
	    	fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event);
	    	var id = $(this).attr('id');
	    	
	    	var indx = id.replace('addressDelete', '');
			$.ajax({
				type : 'POST',
				url : 'deleteOrderAddr',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'addressIndex' : indx
				},
				success : deleteAddressData,
				error : function(ajaxContext) {
					alert("주소를 삭제하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					registerEvent();
				}
			});
	    });
	}
	
	$(document).ready(function() {
		pageInitialize();
		registerEvent();
	});
</script>

