<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

<script type="text/javascript">

	//페이지 처리
	function fnPageSet(text) {
			
		response = text;
		response = $.parseJSON(response);
		var totalPageCount = response.totalPageCount;
		var currentPage = response.currentPage;
		var pageDivNum = response.pageDivNum;
		var totalPrice = response.totalPrice;
		var productsTotalPrice = response.productsTotalPrice;
		
		var trHTML = '';
		
		//Table
		$.each(response.currentPageInfos, function(i, item) {
	
			trHTML +=  
	        '<tr id=\"orderItemList\"' + i +'>' +
	        '<td class=\"cb\">' +
	        '   <input type=\"hidden\" class=\"chkbx\" name=\"chkCartGoodsShShop\" id=\"chkCartGoodsShShop' + i +'\"/>' +
	        '</td>' +
	        '<td class=\"goods_img\">' +
	        '    <a href=\"#\" target=\"_new\" class=\"pd_a\">' +
	        '        <img src="/ShShopTest' + item.imageUrl + '\" class=\"pdimg\"/>' +
	        '    </a>' +
	        '</td>' +
	        '<td class=\"le\">' +
	        '   <a href=\"#\" class=\"pd_a\">'+ item.productName+'</a>' +
	        '    &nbsp;' +
	        '</td>' +
	        '<td>' + item.productPrice + '원</td>' +
	        '<td>' +
	        '    <input type=\"number\" id=\"txtGoodsCnt' + i +'\" name=\"txtGoodsCnt\" value="' + item.quantity + '\" class=\"ipubx num\" maxlength=\"4\" />' +
	        '    <br/>' +
	        '   <input type=\"hidden\" name=\"hdnOriginalGoodsCnt\" value=\"1\" class=\"ipubx num\" /><a href=\"#\" id=\"hdnOriginalGoodsCnt' + i +'\" title=\"변경\" class=\"bw chgnum\">변경</a>' +
	        '</td>' +
	        '<td><strong id=\"totalPricOfItem' + i +'\" value=\"'+ item.orderPrice +'\">'+ item.orderPrice +'원</strong>' +
	        '</td>' + 
	        '<td>' +
	        '    <p class=\"dvmsg\">1일 이내 <br/>배송예정</p>' + 
	        '</td>' + 
	        '<td class=\"goods_order\">' + 
	        '    <p class=\"ordbtnw\">' + 
	        '    <a href=\"#\" title=\"삭제하기\" id=\"deleteItem' + i +'\" class=\"bw pddel\">삭제하기</a>' + 
	        '    </p>' +
	        '</td>' + 
	    	'</tr>';
		});
		
		$('#divGoods tbody').empty();
		$('#divGoods tbody').append(trHTML);
		
		//Set CheckBox
		var hasUnchecked = false;
		$.each(response.currentPageInfos, function(i, item) { 
			if(item.isUnChecked) {
				$('#chkCartGoodsShShop' + i).prop('checked',false);
				hasUnchecked = true;
			} else {
				$('#chkCartGoodsShShop' + i).prop('checked',true);
			}
		});
		
		trHTML =   
	    '<tr>' + 
	    '    <td colspan=\"9\" class=\"tot\">일반카트 상품 총 금액 : ' + 
	    '       <strong id=\"lblTotalAmountCart\">' + productsTotalPrice + '원</strong>' + 
	    '       <span class=\"dvi\"> | </span>' + 
	    '       ShShop포인트 총 적립액 : <strong id=\"lblTotalPointCart\">1,220원</strong> ' + 
	    '       <span id=\"spnTotalPointDetailCart\">(기본 : 1,220원)</span>' + 
	    '   </td>' + 
	    '</tr>';
		
		$('.cartTopItem tfoot').empty();
		$('.cartTopItem tfoot').append(trHTML);
	
		//Page Button
		var btnHtml = '';
		if(currentPage > 1) {
			btnHtml += '<a href=\"#\" id=\"similar_item_list_prev\" class=\"movepreB\">이전 아이템</a>';
		}
		
		btnHtml += '<span id=\"similar_item_list_page\">';
		btnHtml += '<strong>'+ currentPage +'</strong>/' + totalPageCount;
		btnHtml += '</span>'
		
		if(currentPage < totalPageCount)
			btnHtml += '<a href=\"#\" id=\"similar_item_list_next\" class=\"movenextB\">다음 아이템</a>';
	 
		$('.moveBtn').empty();
		$('.moveBtn').append(btnHtml);
		
		//Summery
		var totalDescription = response.totalDescription;
		var productsTotalPrice = response.productsTotalPrice;
		var shippingTotalPrice = response.shippingTotalPrice;
		
		var trSummery = '';
		trSummery +=
		'<td id=\"totalDesciption\"><em>' + totalDescription + '</em></td>' +
		'<td id=\"totalItemsPrice\"><em>' + productsTotalPrice + '</em>원</td>' +
		'<td id=\"txtTotalDelvFare\"><em>' + shippingTotalPrice + '</em>원</td>' +
		'<td class=\"clr1\">' +
		'	<em id=\"txtSaleAmount\">0</em>원' +
		'	<input type=\"hidden\" id=\"hdnSale\" value=\"0\">' +
		'</td>' +
		'<td class=\"clr2\">' +
		'	<em id=\"txtTotalAmount\">' + totalPrice +'</em>원' +
		'	<span id=\"spnGiftPackGbMemo2\" class=\"wfee\" display=\"none\" style=\"display: none;\">' +
		'		(선물포장비 <strong class=\"ls0\">1,000원</strong> 포함)' +
		'	</span>' +
		'</td>';
		
		$('#summeryTotal').empty();
		$('#summeryTotal').append(trSummery); 
	 
		//Event Reset
		fnAjaxLoaderLayerHide("divAjaxLoader");
		
		if(!hasUnchecked)
			$("#chkCartHeader").prop('checked', true);
		else
			$("#chkCartHeader").prop('checked', false);
		
		fnRegisterEvent();
	}
	
	function fnPagePrev(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage -1;
	
		$.ajax({
			type : "POST",
			url : "orderPage",
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage,
			},
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	function fnPageNext(event) {
		event.preventDefault();
	 
		var currentPage = response.currentPage +1;
	
		$.ajax({
			type : "POST",
			url : "orderPage",
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'data-page' : currentPage,
			},
			success : fnPageSet,
			error : function(ajaxContext) {
			}
		});
		return false;
	}
	
	//Cart 상품 전체 선택/선택 해제
	function fnCheckedChangeChildCart() {
		var checked = false;
	
		if ($("#chkCartHeader").is(':checked')) {
			$("#chkCartHeader").prop('checked', true);
			checked = true;
		} else {
			$("#chkCartHeader").prop('checked', false);
			checked = false;
		}
		
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			if ($(this).attr("disabled") != "disabled") {
				$(this).prop('checked', checked);
			}
		});
	}
	
	function fnChangeItemCheckBox() {
		var uncheckedIndex = ''; 
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			var id = $(this).attr('id');
			var indx = id.replace('chkCartGoodsShShop', ''); 
			
			if ($(this).is(':checked') == false) { 
				uncheckedIndex += indx + ',';
			}
		});
		
		$.ajax({
			type : 'POST',
			url : 'changeOrderItemChecked',
			data : {
				'orderKey' : '${requestScope.orderKey}',
				'uncheckedIndx' : uncheckedIndex
			},
			success : fnPageSet,
			error : function(ajaxContext) {
				alert("해당 아이템의 업데이트에 실패하였습니다.");
				fnAjaxLoaderLayerHide("divAjaxLoader");
				fnRegisterEvent();
			}
		});
	}


	function fnPageInitialize(event) {
		$("#chkCartHeader").prop('checked', true);
		$('input:checkbox[name="chkCartGoodsShShop"]').each(function(index) {
			if ($(this).attr("disabled") != "disabled") {
				$(this).prop('checked', true);
			}
		});
		
		fnLayerShowById('divPayMthdCard');
		fnLayerHideById('divPayMthdBankRTime');
		fnLayerHideById('divPayMthdBankAccnt');
		
		fnLayerShowById('ddlCardNormal');
		fnLayerHideById('ddlCardPartner');
		
		fnLayerHideById('divAddressList');
		fnLayerHideById('divAddressNew');
	}
	
	function openModalDialog(refLayerName, layerName) {
		fnPopupLayerShowFixedPosition(refLayerName, layerName)
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
	
    function fnSetPostCode(postCodeHeadId, postCodeTailId,roadId,jibunId ) {
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
    
    function fnAddAddressInfo(index, addrname, username, postHead, postTail, fullAddr, fullAddrNew, phoneNumber) {
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
                        <img class=\"addr_item\" src=\"/ShShopTest/content/image/orderN/btn_putAddr02.gif\" width=\"30\" height=\"13\" alt=\"도로명\">\
                    </div>\
                    <div class=\"putAddrRgt\">\
                        <span class=\"putAddrTxt\"><a href=\"#\" id=\"memberZipCodeNew$INDX$\">($POSTHEAD$-$POSTTAIL$)$FULLADDRNEW$</a></span>\
                    </div>\
                </div>\
                <div class=\"putAddrWrap mgt5\">\
                    <div class=\"putAddrLft\">\
                        <img class=\"addr_item\" src=\"/ShShopTest/content/image/btn_putAddr03.gif\" width=\"30\" height=\"13\" alt=\"지번\">\
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
    
    function fnAddAddressInfoDetail(index, addrname, username, postHead, postTail, fullAddr, fullAddrNew, phoneHead, phoneMid, phoneTail) {
    	var result = "\
    		<table cellpadding=\"0\" class=\"tbl_pay\"  id=\"existingAddressSettings$INDX$\" style=\"display:none\">\
	        <tr id=\"trOrdNmNormal\" style=\"\">\
	        <th>배송지명</th>\
	        <td><input id=\"txtOrdNmNormalExisting$INDX$\" type=\"text\" value=\"$ADDRNAME$\" class=\"ipubx\" /></td>\
		    </tr>\
		    <tr id=\"trDelvAddrNormalExisting$INDX$\" style=\"\">\
		        <th>\
		          	  배송주소\
		        </th>\
		        <td>\
		            <input type=\"text\" id=\"txtZipCode1Existing$INDX$\" value=\"$POSTHEAD$\" class=\"ipubx\" style=\"width: 40px\" readonly=\"readonly\" /> -\
		            <input type=\"text\" id=\"txtZipCode2Existing$INDX$\" value=\"$POSTTAIL$\" class=\"ipubx\" style=\"width: 40px\" readonly=\"readonly\" />\
		            </a>\
		            <br/>\
		            <p style=\"margin:5px 0;\">도로명 주소\
		                <input type=\"text\" id=\"txtAddressByStExisting$INDX$\" class=\"ipubx\"\
		                       value=\"$FULLADDRNEW$\"\
		                       style=\"width:320px;vertical-align:middle;\" readonly=\"readonly\" />\
		            </p>\
		            <p style=\"line-height:20px;\">지번 주소&nbsp;&nbsp;&nbsp;\
		                <input type=\"text\" id=\"txtAddressByOldExisting$INDX$\"\
		                       value=\"$FULLADDR$\"\
		                       class=\"ipubx\"\
		                       style=\"width:320px;vertical-align:middle;\" readonly=\"readonly\" />\
		            </p>\
		        </td>\
		    </tr>\
		    <tr id=\"trDelvMobNoNormalExisting$INDX$\" style=\"\">\
		        <th>\
		           	 핸드폰\
		        </th>\
		        <td class=\"num_p\" style=\"height: 22px;\">\
		            <select id=\"ddlRcvrMobTelNo1NormalExisting$INDX$\" style=\"width: 50px; margin-bottom: 1px; vertical-align: bottom\">\
		                <option value=\"\">선택</option>";
	
		  result += fnMakePhoneSelectHtml(phoneHead);
		  
		  result +=  "  </select> -\
		            <input type=\"text\" id=\"txtRcvrMobTelNo2NormalExisting$INDX$\" value=\"$PHONEMID$\" class=\"ipubx\" maxlength=\"4\"/> -\
		            <input type=\"text\" id=\"txtRcvrMobTelNo3NormalExisting$INDX$\" value=\"$PHONETAIL$\" class=\"ipubx\" maxlength=\"4\"/>\
		        </td>\
		    </tr>\
		    </table>";
		    
	      result = result.split('$INDX$').join(index);
	      result = result.split('$ADDRNAME$').join(addrname);
	      result = result.split('$POSTHEAD$').join(postHead);
	      result = result.split('$POSTTAIL$').join(postTail);
	      result = result.split('$FULLADDRNEW$').join(fullAddrNew);
	      result = result.split('$FULLADDR$').join(fullAddr);
	      result = result.split('$PHONEMID$').join(phoneMid);
	      result = result.split('$PHONETAIL$').join(phoneTail);
	      
	      return result;
    }
    
    function fnMakePhoneSelectHtml(phoneNumberHead) { 

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
    
	function fnAjaxhangeAddressData(text) {
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
		var phoneHtml = fnMakePhoneSelectHtml(phoneHead);
		
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
		openModalDialog('rdoDelvAddrSetModeNew', 'divAddressList');
		fnAjaxLoaderLayerHide("divAjaxLoader");
		fnRegisterEvent();
	}
	
	function fnAjaxAddAddressData(text) {
 
		if( text.toLowerCase() == ("This input exceeded the size that can be input.( Maximum 5 )").toLowerCase()) {
			alert("최대 등록 가능 주소 개수는 5 개를 넘을 수 없습니다.");	
		} else {
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
			var phoneHead = response.addressPhoneNumberHead;
			var phoneMid = response.addressPhoneNumberMid;
			var phoneTail = response.addressPhoneNumberTail;
			
			var appendText = fnAddAddressInfo(indx, addrName, userName, zipHead, zipTail, basicAdd + detailAdd, basicAddNew + detailAdd, phoneNumber);
			$("#addressInfoTable tbody").append(appendText);
		    	
			var appendTextDetail = fnAddAddressInfoDetail(indx, addrName, userName, zipHead, zipTail, basicAdd + detailAdd, basicAddNew + detailAdd, phoneHead, phoneMid, phoneTail);
			$("#existingAddressLayer").append(appendTextDetail);
		}

		fnAjaxLoaderLayerHide("divAjaxLoader");
		fnRegisterEvent();
	}
	
	function fnDeleteAddressData(text) {
		response = text;
		response = $.parseJSON(response);
		var indx = response.addrIndex;
		$('#addressInfoItem' + indx).empty();
		fnAjaxLoaderLayerHide("divAjaxLoader");
		fnRegisterEvent();
	}
	
 
	function fnRegisterEvent() {
	    $('#chkCartHeader').change(function() {
	    	fnCheckedChangeChildCart();
	    	
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2('chkCartHeader',"divAjaxLoader",50,30);	
			
			fnChangeItemCheckBox();
	    });
	    
	    $('input:checkbox[name="chkCartGoodsShShop"]').change(function() {
	    	var id = $(this).attr('id');
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2(id,"divAjaxLoader",50,30);	
			
			fnChangeItemCheckBox();
	    }); 
	    
	    $('.chgnum').unbind('click').bind('click', function (e) {
	    	event.preventDefault();
	    	
			var checkedId = $(this).attr('id');
			var indx = checkedId.replace('hdnOriginalGoodsCnt', '');
			var newQuantity = parseInt($('#txtGoodsCnt' + indx).val());
			$('#txtGoodsCnt' + indx).attr('value', newQuantity);
			
			if(newQuantity <= 0) {
				alert('유효하지 않은 수량을 입력하셨습니다.');
			}
			
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2('txtGoodsCnt' + indx,"divAjaxLoader",50,30);
			
			$.ajax({
				type : 'POST',
				url : 'changeOrderItemCount',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'orderIndex' : indx,
					'itemNewQuantity' : newQuantity
				},
				success : fnPageSet,
				error : function(ajaxContext) {
					alert("변경된 수량으로 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
	    $('.pddel').unbind('click').bind('click', function (e) {
	    	event.preventDefault();
	    	
			var checkedId = $(this).attr('id');
			var indx = checkedId.replace('deleteItem', '');
			
			fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event); 
			fnPopupLayerShowFixedPosition2(checkedId, "divAjaxLoader",50,30);
			
			$.ajax({
				type : 'POST',
				url : 'deleteOrder',
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'orderIndex' : indx
				},
				success : fnPageSet,
				error : function(ajaxContext) {
					alert("해당 아이템을 삭제하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
		$('#similar_item_list_prev').click(fnPagePrev);
		$('#similar_item_list_next').click(fnPageNext);
		
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
				openModalDialog('rdoDelvAddrSetModeNew','divAddressList');
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

		$('#addrChooser').unbind('click').bind('click', function (e) {
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
		
	    $("#aZipFind").unbind('click').bind('click', function (e) {
	    	fnSetPostCode('txtZipCode1New','txtZipCode2New','txtAddressByStNew','txtAddressByOldNew');
	    });
 
	    $('.modif').unbind('click').bind('click', function (e) {
	    	var id = $(this).attr('id');
	    	
	    	var indx = id.replace('addressModify', '');
	    	var addressNewId = 'divAddressNew' + indx;
	    	fnLayerHideById('divAddressList');
	    	openModalDialog('rdoDelvAddrSetModeNew', addressNewId);
	    });
	    
	    $('.sch_address').unbind('click').bind('click', function (e) {
	    	var id = $(this).attr('id');
	    	var indx = id.replace('aZipFinderSub', '');
	    	fnSetPostCode('txtZipCd1New'+ indx,'txtZipCd2New'+ indx,'txtAddressNewBySt'+ indx,'txtAddressNewByOld'+ indx);
	    });
	    
	    $('.cfrm').unbind('click').bind('click', function (e) {
	    	fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event);
	    	
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
				success : fnAjaxhangeAddressData,
				error : function(ajaxContext) {
					alert("변경된 주소를 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
	    $('#addNewAddress').unbind('click').bind('click', function (e) {
	    	fnAjaxLoaderLayerShow("divAjaxLoader", true, false, window.event);
	    	
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
				success : fnAjaxAddAddressData,
				error : function(ajaxContext) {
					alert("변경된 주소를 업데이트 하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
	    $('.delet_s').unbind('click').bind('click', function (e) {
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
				success : fnDeleteAddressData,
				error : function(ajaxContext) {
					alert("주소를 삭제하지 못했습니다.");
					fnAjaxLoaderLayerHide("divAjaxLoader");
					fnRegisterEvent();
				}
			});
	    });
	    
	    $('#btnPayment').unbind('click').bind('click', function (e) { 
	    	$('#divAjaxLoaderOrder').css('display', 'block'); 
	    	
	    	setTimeout(function(){ 
	    		$('#divAjaxLoaderOrder').css("display", "none");
	    		
	    		//조건체크
	    		
	    		
	    		var href = $('#btnPayment').attr('href');
		        location.href = href;
	        }, 2000);  
	    	

 
	        return false;
	    });
	}
	
	$(document).ready(function() {
		$(document).ready(function() {
			$.ajax({
				type : "POST",
				url : "orderPage",
				data : {
					'orderKey' : '${requestScope.orderKey}',
					'data-page' : '1',
				},
				success : fnPageSet,
				error : function(ajaxContext) {
				}
			});
		});
		fnPageInitialize();
		fnRegisterEvent();
	});
</script>

