// AJAX Loding Image 보이기
function fnAjaxLoaderLayerShow(divAjaxLoaderId, isCenterPosition, mouse, myEvent, isMain) {
	if (myEvent == undefined) {
		myEvent = window.event;
	}

	$("#" + divAjaxLoaderId).css("display", "");
	try {
		if (isMain == undefined) {
			$("#" + divAjaxLoaderId).html("<img src='http://www.broadwaybalancesamerica.com/images/ajax-loader.gif' align='center' alt='' />");
			$("#" + divAjaxLoaderId).css("position", "absolute");
		} else {
			$("#" + divAjaxLoaderId).html("<img src='https://secimage.yes24.com/sysimage/orderN/pay_loading.gif' alt='' />");
			$("#" + divAjaxLoaderId).css("position", "relative");
			$("#" + divAjaxLoaderId).css("left", 0);
		}

		$("#" + divAjaxLoaderId).css("z-index", "10000000");
		if (isMain == undefined) {
			$("#" + divAjaxLoaderId).css("left", document.body.clientWidth / 2);
			if (isCenterPosition == true) {
				$("#" + divAjaxLoaderId).css("top", document.body.clientHeight / 2);
			} else {
				$("#" + divAjaxLoaderId).css("top", parseInt(document.body.scrollTop) + parseInt(myEvent.clientY) + 10);
			}
			if (mouse == true) {
				$("#" + divAjaxLoaderId).css("top", parseInt(document.body.scrollTop) + myEvent.y);
				$("#" + divAjaxLoaderId).css("left", parseInt(document.body.scrollLeft) + myEvent.x);
				var pos = abspos(myEvent);
				$("#" + divAjaxLoaderId).css("left", pos.x + "px");
				$("#" + divAjaxLoaderId).css("top", (pos.y + 10) + "px");
			}
		}
	} catch (ex) {
	}
}

function abspos(e) {
	this.x = e.clientX + (document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft);
	this.y = e.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);
	return this;
}

// AJAX Loding Image 숨기기
function fnAjaxLoaderLayerHide(divAjaxLoaderId) {
	setTimeout(function(){ 
		$("#" + divAjaxLoaderId).empty();
		$("#" + divAjaxLoaderId).css("display", "none");
    }, 500);  
}

//문자열이 허용 Ascii Code 범위 인지 확인(숫자, 영문 대소문자, [ ], [.], [,], ['], ["], [-], [/]
function fnInputValueCheckAscii2(address) {
	for (var i = 0; i < address.length; i++) {
		if ((address.charAt(i) < "0" || address.charAt(i) > "9") && (address.charAt(i) < "A" || address.charAt(i) > "Z")
				&& (address.charAt(i) < "a" || address.charAt(i) > "z") && address.charAt(i) != " " && address.charAt(i) != "."
				&& address.charAt(i) != "," && address.charAt(i) != "'" && address.charAt(i) != '"' && address.charAt(i) != "-"
				&& address.charAt(i) != "/" && address.charAt(i) != "#") {
			return false;
		}
	}
	return true;
}

//지정한 Control로 Focus 이동
function fnMoveFocusSelToText(currentControl, nextControlName) {
	if (document.getElementById(nextControlName) != undefined) {
		document.getElementById(nextControlName).focus();
		document.getElementById(nextControlName).select();
	}
}

//Popup 성격의 Layer 보이기
function fnPopupLayerShow(layerName, isCenterPositionX, myEvent) {
	if (myEvent == undefined) {
		myEvent = window.event;
	}

	$("#" + layerName).css("display", "");
	var width = $("#" + layerName).css("width").replace("px", "");
	var height = $("#" + layerName).css("height").replace("px", "");
	
	if (isCenterPositionX == true) {
		$("#" + layerName).css("left", ((document.body.clientWidth / 2) - (parseInt(width) / 2)) + 'px');
		$("#" + layerName).css("top", (parseInt(document.body.scrollTop) + parseInt(myEvent.clientY)) + 'px');
	} else {
		$("#" + layerName).css("left", ((parseInt(myEvent.clientX) - (parseInt(width) / 2)) | 0) + 'px');
		$("#" + layerName).css("top", ((parseInt(document.body.scrollTop) + parseInt(myEvent.clientY) + 10) | 0) + 'px');

		if (layerName == "divGiftPackInfo") {
			$("#" + layerName).css("left", ((parseInt(myEvent.clientX) - (parseInt(width) / 2) - 230) | 0) + 'px');
		}
	}
}

//Popup 성격의 Layer 보이기 - 위치 지정
function fnPopupLayerShowPosition(layerName, left, top, myEvent) {
	if (myEvent == undefined) {
		myEvent = window.event;
	}

	$("#" + layerName).css("display", "");
	var width = $("#" + layerName).css("width").replace("px", "");
	var height = $("#" + layerName).css("height").replace("px", "");
	$("#" + layerName).css("left", parseInt(myEvent.clientX) - (parseInt(width) / 2) + parseInt(left));
	$("#" + layerName).css("top", parseInt(document.body.scrollTop) + parseInt(myEvent.clientY) + parseInt(top));
}

//Popup 성격의 Layer 보이기 - 위치 불변 지정  / milestoneName 기준이되는 id
function fnPopupLayerShowFixedPosition(milestoneName, layerName) {
	var mHeight = parseInt($("#" + milestoneName).css("height").replace("px", ""));
	var mWidth = parseInt($("#" + milestoneName).css("width").replace("px", ""));

	var top = $("#" + milestoneName).offset().top + mHeight;
	var left = $("#" + milestoneName).offset().left + ((mWidth / 2) | 0);

	$("#" + layerName).css("position", "absolute");
	$("#" + layerName).css("display", "");

	var width = parseInt($("#" + layerName).css("width").replace("px", "")) / 2;
	$("#" + layerName).offset({
		top : top,
		left : left - width
	});
}

function fnPopupLayerShowFixedPosition2(milestoneName, layerName, offsetTop, offsetLeft) {
	var mHeight = parseInt($("#" + milestoneName).css("height").replace("px", ""));
	var mWidth = parseInt($("#" + milestoneName).css("width").replace("px", ""));

	var top = $("#" + milestoneName).offset().top-offsetTop;
	var left = $("#" + milestoneName).offset().left+offsetLeft;

	$("#" + layerName).css("position", "absolute");
	$("#" + layerName).css("display", "");

	var width = parseInt($("#" + layerName).css("width").replace("px", "")) / 2;
	$("#" + layerName).offset({
		top : top,
		left : left - width
	});
}

//Popup 성격의 Layer 숨기기
function fnPopupLayerHide(layerName) {
	$("#" + layerName).css("display", "none");
}

//Popup 성격의 Layer 숨기기
function fnPopupLayerRemove(layerName) {
	$("#" + layerName).remove();
}

//Popup 성격의 Layer 보이기
function fnWindowOpen(url, popupName, width, height, isCenterPosition, left, top) {
	if (isCenterPosition == true) {
		left = (((document.body.clientWidth / 2) - (width / 2)) | 0);
		top = (((document.body.clientHeight / 2) - (height / 2)) | 0);
	}
	var features = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top
			+ ",toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,status=no";

	return window.open(url, popupName, features);
}

//Popup 성격의 Layer 보이기
function fnWindowOpenFeatures(url, popupName, width, height, isCenterPosition, left, top, etcFeatures) {
	if (isCenterPosition == true) {
		left = (document.body.clientWidth / 2) - (width / 2);
		top = (document.body.clientHeight / 2) - (height / 2);
	}
	var features = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top + "," + etcFeatures;
	return window.open(url, popupName, features);
}

//문자열에서 지정한 문자열을 특정 문자열로 치환
function fnReplaceAll(value, character, replaceCharacter) {
	if (value == null) {
		return value;
	}

	value = value.replace(character, replaceCharacter);

	if (value.indexOf(character) > -1) // 바꿀 문자가 존재하면 재귀 호출
	{
		return fnReplaceAll(value, character, replaceCharacter);
	} else {
		return value;
	}
}

//지정한 레이어 숨기기
function fnLayerHideById(layerName) {
	$('#' + layerName).css('display', 'none');
}

//지정한 레이어 보이기
function fnLayerShowById(layerName) {
	$('#' + layerName).css('display', 'block');
}
