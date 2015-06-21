<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<script src="${adminBean.contextPath}/content/js/common.js"></script>

<script type="text/javascript">

	//Cart내에서 단일 상품 정보 수정 
	function fnCartModifyGoods(modifyMode, cartSeq, goodsNo, goodsSeq, goodsCnt, dispNo, goodsSeqOrdMsg)
	{        
	    if ( checkAdultAuth == false )
	    {
	        return;
	    }
	
	    var concatChar1 = "";
	    var hdnGoodsCnt = "";
	    switch (modifyMode)
	    {
	        case "UPDATE":
	        case "UPDATE_GOODS_CNT":            
	            goodsCnt = $("#txtGoodsCnt" + goodsNo + goodsSeq).attr("value").replace(/^ *| *$/g, "");
	            hdnGoodsCnt = $("#hdnGoodsCnt" + goodsNo + goodsSeq).attr("value").replace(/^ *| *$/g, "");
	            if ((fnIsNaturalNumber(goodsCnt) == false) || (goodsCnt.length < 1))
	            {
	                alert("올바른 상품 수량을 입력하여 주세요.");
	                $("#txtGoodsCnt" + goodsNo + goodsSeq).focus();
	                return;
	            }
	
	            goodsCnt = parseInt(goodsCnt,10);
	            hdnGoodsCnt = parseInt(hdnGoodsCnt,10);
	            if (goodsCnt < 1)
	            {
	                alert("상품 수량은 1개 이상을 입력하여 주세요.");
	                $("#txtGoodsCnt" + goodsNo + goodsSeq).focus();
	                return;
	            }
	           
	            if (goodsCnt == hdnGoodsCnt)
	            {
	                alert("변경된 수량이 없습니다.");
	                $("#txtGoodsCnt" + goodsNo + goodsSeq).focus();
	                return;
	            }
	
	            var fromCnt = $("#hdnFromCount" + goodsNo + goodsSeq).attr("value");
	            var toCnt = $("#hdnToCount" + goodsNo + goodsSeq).attr("value");
	            fromCnt = parseInt(fromCnt,10);
	            toCnt = parseInt(toCnt,10);
	             
	            if (fromCnt > 0 && toCnt > 0)
	            {
	                if (goodsCnt < fromCnt || goodsCnt > toCnt)
	                {
	                    alert("선택옵션에 맞는 주문수량을 구매하셔야 옵션가격을 적용받으실 수 있습니다.");
	                    return;
	                }
	            }
	            
	            var maxAatPerOrd = $("#hdnMaxAatPerOrd" + goodsNo + goodsSeq).attr("value");
	            maxAatPerOrd = parseInt(maxAatPerOrd,10);
	            if (maxAatPerOrd != 0 &&
	                goodsCnt > maxAatPerOrd)
				{
					alert("최대 허용 주문 수량을 초과 하였습니다.");
	                $("#txtGoodsCnt" + goodsNo + goodsSeq).attr("value", maxAatPerOrd);
					return;
				}
	            break;
	        case "UPDATE_AFT_ORD_Y":
	        case "UPDATE_AFT_ORD_N":
	            break;
	        case "UPDATE_GOODS_SEQ_ORD_MSG":
	            cartSeq = $("#hdnGoodsOptionInfoCartSeq").attr("value");
	            goodsNo = $("#hdnGoodsOptionInfoGoodsNo").attr("value");
	            goodsSeq = parseInt($("#ddlGoodsSeq" + gGoodsDDLIndex + " option:selected").val(),10);
	            goodsCnt = $("#txtGoodsOptionInfoGoodsCount").attr("value");
	            var fromCnt = $("#ddlGoodsSeq" + gGoodsDDLIndex + " option:selected").attr("fromCount");
	            var toCnt = $("#ddlGoodsSeq" + gGoodsDDLIndex + " option:selected").attr("toCount");;
	            goodsCnt = parseInt(goodsCnt,10);
	            fromCnt = parseInt(fromCnt,10);
	            toCnt = parseInt(toCnt,10);
	
	            if (fromCnt > 0 && toCnt > 0)
	            {
	                if (goodsCnt < fromCnt || goodsCnt > toCnt)
	                {
	                    alert("선택옵션에 맞는 주문수량을 구매하셔야 옵션가격을 적용받으실 수 있습니다.");
	                    return;
	                }
	            }
	           
	            goodsSeqOrdMsg = $("#txtGoodsSeqOrderMessage").val();
	            if (fnIsNaturalNumber(goodsCnt) == false)
	            {
	                alert("올바른 상품 수량을 입력하여 주세요.");
	                $("#txtGoodsOptionInfoGoodsCount").focus();
	                return;
	            }
	
	            if (goodsCnt < 1)
	            {
	                alert("상품 수량은 1개 이상을 입력하여 주세요.");
	                $("#txtGoodsOptionInfoGoodsCount").focus();
	                return;
	            }
	
	            if (($("#trtxtMessage").css("display") == "" || $("#trtxtMessage").css("display") == "block") && goodsSeqOrdMsg == "")
	            {
	                alert("이니셜 및 메시지를 입력하여 주세요.");
	                $("#txtGoodsSeqOrderMessage").focus();
	                return;
	            }
	
	            if (goodsSeqOrdMsg.length > 100)
	            {
	                alert("이니셜 및 메시지 입력은 100자 이내만 가능합니다.");
	                $("#txtGoodsSeqOrderMessage").focus();
	                return;
	            }
	            
	            if (goodsSeq == 0)  // && gGoodsDDLIndex != 1
	            {
	                alert("상품 옵션을 선택하여 주세요.");
	                return;
	            }
	            break;
	        case "DELETE":
	        case "DELETE_AFTER_ORDER":
	            if (confirm("선택한 상품을 삭제 하시겠습니까?") == false)
	            {
	                return;
	            }
	            goodsCnt = 0;
	            break;
	        case "INSERT":
	            goodsCnt = 1;
	            break;
	    }
	
	    if (goodsSeq == 0)
	    {
	        goodsSeq = 1;
	    }
	    
	    var goods = {
	            "modifyMode" : modifyMode,
	            "cartSeq" : cartSeq, 
	            "goodsNo" : goodsNo,
	            "goodsSeq" : goodsSeq,
	            "goodsCnt" : goodsCnt,
	            "dispNo" : dispNo,
	            "goodsSeqOrdMsg" : escape(goodsSeqOrdMsg),
	            "divThanksYesBonusCloseYn" : $("#hdnDivThanksYesBonusCloseYn").attr("value")
	        };
	   
	    fnAjaxLoaderLayerShow("divAjaxLoader", false, false, window.event);
	    $.post(
	        "/Cart/CartModifyGoods",
	        goods,
	        function (data) {
	            fnAjaxLoaderLayerHide("divAjaxLoader");
	            fnCartDisplay(data, modifyMode);
			}
	    );
	}
</script>

