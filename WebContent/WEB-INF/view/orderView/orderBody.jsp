<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div id="yesWrap">
    <div id="wrapperContent">
        <div id="divGoodsOrderDetail" style="">
                <!--// 상품확인 -->
                <div id="divGoods">
                	</br></br>
                    <h3><span class='tbl_t pdchk'>상품확인</span></h3>
                    <table class='tbl_l'>
                        <colgroup>
                            <col width='70' />
                            <col width='' />
                            <col width='90' /> 
                            <col width='70' />
                            <col width='90' />
                            <col width='80' />
                        </colgroup>
                        <thead>
                            <tr>
                                <th colspan='2'>
                                    <em class='name'>상품명</em>
                                </th>
                                <th>
                                    <em class='fpri'>가격</em>
                                </th>
                                <th>
                                    <em class='numb'>수량</em>
                                </th>
                                <th>
                                    <em class='tota'>합계</em>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class='last'>
                                <td class='goods_img le'>
                                    <a href='http://www.yes24.com/24/Goods/18242263' class='pd_a' target='_blank'>
                                        <img src='https://secimage.yes24.com/Goods/18242263/60x0' alt='' class='pdimg' target='_blank' />
                                    </a>
                                </td>
                                <td>
                                    <a href='http://www.yes24.com/24/Goods/18242263' class='pd_a'>[도서] 고미숙의 로드클래식, 길 위에서 길 찾기</a>
                                </td>
                                <td>
                                    15,000원
                                </td>
 
                                <td>
                                    1
                                </td>
                                <td><strong>13,500원</strong>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id='divDiscount' class='dc_area' style=''>
                    </div>
                </div>

                <!-- 상품확인 //-->

                <!-- // 배송주소 -->
                <div id="divDelvAddr" class="pay_w" style="">
                    <h3><span class="tbl_t dlv_address">배송주소</span></h3>
                    <div class="col2">
                        <div class="inf_mem">
                            <h4 class="tbl_t">주문고객</h4>
                            <table cellpadding="0" cellspacing="0" class="tbl_pay" style="display:none">
                                <tr>
                                    <th>
                                        <strong>회원정보</strong>
                                    </th>
                                    <td>

                                        <div id="divMemInfo"><strong>김대웅</strong>
                                            <br />서울특별시 중구 충무로3가 59-13 9 해피하우스 602호
                                            <br />043-742-0196 <em class="dvi">/</em> 010-3224-0196
                                            <br />xxxx3303@hanmail.net</div>
                                        <input type="hidden" id="hdnMemNm" value="김대웅" />
                                        <input type="hidden" id="hdnMemEml" value="xxxx3303@hanmail.net" />
                                        <input type="hidden" id="hdnAddrTelNo" value="043-742-0196" />
                                        <input type="hidden" id="hdnAddrMobNo" value="010-3224-0196" />

                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" class="tbl_pay">
                                <tr>
                                    <th>
                                        이름
                                    </th>
                                    <td>
                                        <input type="text" id="txtMemNm" value="김대웅" class="ipubx" />

                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        핸드폰
                                    </th>
                                    <td class="num_p">
                                        <select id="ddlAddrMobNo1" style="width: 72px; margin-bottom: 1px; vertical-align: bottom"
                                                onchange="fnChangeAddrNo(this); fnMoveFocusSelToText(this, 'txtAddrMobNo2');">
                                            <option value="">선택</option>
                                            <option value="010" selected="selected">010</option>
                                            <option value="011">011</option>
                                            <option value="016">016</option>
                                            <option value="017">017</option>
                                            <option value="018">018</option>
                                            <option value="019">019</option>
                                            <option value="00">선택안함</option>
                                        </select> -
                                        <input type="text" id="txtAddrMobNo2" value="3224" onkeyup="fnMoveFocus(this, 'txtAddrMobNo3', 4);"
                                               onfocus="this.select();" class="ipubx" maxlength="4" /> -
                                        <input type="text" id="txtAddrMobNo3" value="0196" class="ipubx" maxlength="4" onfocus="this.select();" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        일반전화
                                    </th>
                                    <td class="num_p">
                                        <select id="ddlAddrTelNo1" style="width: 72px; margin-bottom: 1px; vertical-align: bottom"
                                                onchange="fnChangeAddrNo(this); fnMoveFocusSelToText(this, 'txtAddrTelNo2');">
                                            <option value="">선택</option>
                                            <option value="02">02</option>
                                            <option value="031">031</option>
                                            <option value="032">032</option>
                                            <option value="033">033</option>
                                            <option value="041">041</option>
                                            <option value="042">042</option>
                                            <option value="043" selected="selected">043</option>
                                            <option value="044">044</option>
                                            <option value="051">051</option>
                                            <option value="052">052</option>
                                            <option value="053">053</option>
                                            <option value="054">054</option>
                                            <option value="055">055</option>
                                            <option value="061">061</option>
                                            <option value="062">062</option>
                                            <option value="063">063</option>
                                            <option value="064">064</option>
                                            <option value="070">070</option>
                                            <option value="0502">0502</option>
                                            <option value="0503">0503</option>
                                            <option value="0505">0505</option>
                                            <option value="0506">0506</option>
                                            <option value="0507">0507</option>
                                            <option value="0508">0508</option>
                                            <option value="010">010</option>
                                            <option value="011">011</option>
                                            <option value="016">016</option>
                                            <option value="017">017</option>
                                            <option value="018">018</option>
                                            <option value="019">019</option>
                                            <option value="00">선택안함</option>
                                        </select> -
                                        <input type="text" id="txtAddrTelNo2" value="742" class="ipubx"
                                               onkeyup="fnMoveFocus(this, 'txtAddrTelNo3', 4);" onfocus="this.select();" maxlength="4" /> -
                                        <input type="text" id="txtAddrTelNo3" value="0196" class="ipubx" maxlength="4" onfocus="this.select();" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        이메일
                                    </th>
                                    <td class="eml_w">
                                        <input type="text" id="txtMemEml" value="xxxx3303@hanmail.net" class="ipubx" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <table cellpadding="0" cellspacing="0" class="tbl_pay">
                            <tr id="tr_delv_addr">
                                <th>
                                    배송지
                                </th>
                                <td class="dlv_adrs">
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoDelvAddrSetModeLast" name="rdoDelvAddrSetMod"
                                               onclick="fnRdoDelvAddrSetModChanged()" value="LAST" class="rdbtn" checked="checked" /> 최근배송지 
                                        <a href="javascript:" onclick="fnShowAddressList('LastDelivery', 'Member', '', event); return false;" 
                                           class="bw viewmore" title="더보기">더보기</a>       
                                    </span>
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoDelvAddrSetModeList" name="rdoDelvAddrSetMod" 
                                               onclick="fnShowAddressList('Member', 'LastDelivery', '', event);" value="LIST" class="rdbtn" /> 주소록           
                                    </span>
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoDelvAddrSetModeMember" name="rdoDelvAddrSetMod" 
                                               onclick="fnRdoDelvAddrSetModChanged()" value="MEMBER" class="rdbtn" /> 회원정보동일
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" class="tbl_pay">
                            <tr id="trOrdNmNormal" style="">
                                <th>
                                    이름
                                </th>
                                <td>
                                    <input id="txtOrdNmNormal" type="text" value="김대웅" class="ipubx" />
                                    <input type="hidden" id="hdnLastNormalRcvrNm" value="김대웅" />
                                    <input type="hidden" id="hdnLastNormalZipCd" value="100-013" />
                                    <input type="hidden" id="hdnLastNormalAddr1" value="서울특별시 중구 충무로3가 59-13" />
                                    <input type="hidden" id="hdnLastNormalAddr2" value="9 해피하우스 602호 " />
                                    <input type="hidden" id="hdnLastNormalAddr3" value="서울특별시 중구 수표로 10" />
                                    <input type="hidden" id="hdnLastNormalAddr4" value="충무로3가" />
                                    <input type="hidden" id="hdnLastNormalZipSeqCd" value="001" />
                                    <input type="hidden" id="hdnLastNormalRcvrMobTelNo" value="010-3224-0196" />
                                    <input type="hidden" id="hdnLastNormalRcvrTelNo" value="--" />
                                    <input type="hidden" id="hdnLastNormalBuMngNo" value="1114015800100590013017709" />
                                </td>
                            </tr>
                            <tr id="trOrdNmStore" style="display: none">
                                <th>
                                    이름
                                </th>
                                <td>
                                    <input id="txtOrdNmStore" type="text" value="" class="ipubx" />
                                </td>
                            </tr>

                            <tr id="trOrdNmCrema" style="display: none">
                                <th>
                                    	이름
                                </th>
                                <td>

                                    <input id="txtOrdNmCrema" type="text" value="" class="ipubx" />
                                </td>

                            </tr>

                            <tr id="trDelvAddrNormal" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1" value="100" class="ipubx" style="width: 40px"
                                           onclick="javascript:LoadPostalCode('aZipFind');" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2" value="013" class="ipubx" style="width: 40px" readonly="readonly"
                                           onclick="javascript:LoadPostalCode('aZipFind');" />
                                    <input type="hidden" id="hdnZipSeqCd" value="001" />
                                    <input type="hidden" id="hdnZipSelectMode" value="" />
                                    <a href="javascript:" onclick="LoadPostalCode('aZipFind'); return false;" title="주소 찾기" 
                                       class="bw sch_address" id="aZipFind">주소 찾기   
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressBySt" class="ipubx" onblur="fnAddressModifyApply();" 
                                               value="서울특별시 중구 수표로 10, 9 해피하우스 602호 (충무로3가)" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOld" onblur="fnAddressModifyApply();" 
                                               value="서울특별시 중구 충무로3가 59-13 9 해피하우스 602호 " class="ipubx" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                        <input type="hidden" id="txtAddress1Normal" value="서울특별시 중구 충무로3가 59-13" />
                                        <input type="hidden" id="txtAddress2Normal" value="9 해피하우스 602호 " />
                                        <input type="hidden" id="hdnAddress1NormalBySt" value="서울특별시 중구 수표로 10" />
                                        <input type="hidden" id="hdnAddress2NormalBySt" value="충무로3가" />
                                        <input type="hidden" id="hdnBuMngNoBySt" value="1114015800100590013017709" />
                                        <input type="hidden" id="hdnValidateDoro" value="true" />
                                        <a href="#" title="주소록에 추가" class="bw add_adrs">주소록에 추가</a>
                                    </p> 
                                </td>
                            </tr>

                            <tr id="trDelvMobNoNormal" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1Normal" style="width: 50px; margin-bottom: 1px; vertical-align: bottom"
                                            onchange="fnMoveFocusSelToText(this, 'txtRcvrMobTelNo2Normal'); fnMobTelCheck();">
                                        <option value="">선택</option>
                                        <option value="010" selected="selected">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2Normal" value="3224" class="ipubx" maxlength="4" 
                                           onkeyup="fnMoveFocus(this, 'txtRcvrMobTelNo3Normal', 4);" onfocus="this.select();" /> -
                                    <input type="text" id="txtRcvrMobTelNo3Normal" value="0196" class="ipubx" maxlength="4" onfocus="this.select();" />
                                </td>
                            </tr>
                            <tr id="trDelvMobNoStore" style="display: none">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1Store" style="width: 50px; margin-bottom: 1px; vertical-align: bottom"
                                            onchange="fnMoveFocusSelToText(this, 'txtRcvrMobTelNo2Store');">
                                        <option value="">선택</option>
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2Store" value="" class="ipubx" maxlength="4" 
                                           onkeyup="fnMoveFocus(this, 'txtRcvrMobTelNo3Store', 4);" onfocus="this.select();" /> -
                                    <input type="text" id="txtRcvrMobTelNo3Store" value="" class="ipubx" maxlength="4" onfocus="this.select();" />
                                    <img src="https://secimage.yes24.com/sysimage/mypage/i_smsBlue.gif" alt="SMS" hspace="2px" valign="middle" />
                                </td>
                            </tr>

                            <tr id="trDelvTellNoNormal" style="">
                                <th>
                                    	일반전화
                                </th>
                                <td class="num_p" style="height: 18px;">
                                    <select id="ddlRcvrTelNo1Normal" style="width: 50px; margin-bottom: 1px; vertical-align: bottom"
                                            onchange="fnMoveFocusSelToText(this, 'txtRcvrTelNo2Normal'); fnTelCheck();">
                                        <option value="">선택</option>
                                        <option value="02">02</option>
                                        <option value="031">031</option>
                                        <option value="032">032</option>
                                        <option value="033">033</option>
                                        <option value="041">041</option>
                                        <option value="042">042</option>
                                        <option value="043">043</option>
                                        <option value="044">044</option>
                                        <option value="051">051</option>
                                        <option value="052">052</option>
                                        <option value="053">053</option>
                                        <option value="054">054</option>
                                        <option value="055">055</option>
                                        <option value="061">061</option>
                                        <option value="062">062</option>
                                        <option value="063">063</option>
                                        <option value="064">064</option>
                                        <option value="070">070</option>
                                        <option value="0502">0502</option>
                                        <option value="0503">0503</option>
                                        <option value="0505">0505</option>
                                        <option value="0506">0506</option>
                                        <option value="0507">0507</option>
                                        <option value="0508">0508</option>
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                    </select> -
                                    <input type="text" id="txtRcvrTelNo2Normal" value="" class="ipubx" 
                                           onkeyup="fnMoveFocus(this, 'txtRcvrTelNo3Normal', 4);" onfocus="this.select();" maxlength="4" /> -
                                    <input type="text" id="txtRcvrTelNo3Normal" value="" class="ipubx" onfocus="this.select();" maxlength="4" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- 배송주소 // -->
                <!-- // 결제방법 -->
                <div class="pay_w">
                    <h3><span class="tbl_t paym_t" id="lblOrderPaymentMethodTitle">결제방법</span></h3>
                    <div class="col2">
                        <div class="added_w" id="divPayMethodValues" style="">

                            <!--// Hidden Filed Counter -->
                            <input type="hidden" name="ModelCounterYes24" id="ModelCounterYes24" value="1" />
                            <input type="hidden" name="ModelCounterDigital" id="ModelCounterDigital" value="0" />
                            <input type="hidden" name="ModelCounterCosmetic" id="ModelCounterCosmetic" value="0" />
                            <input type="hidden" name="ModelCounterVendor" id="ModelCounterVendor" value="0" />

                            <!-- // 부가옵션 -->
                            <div style="" class="added">
                                <table cellpadding="0" cellspacing="0" class="tbl_pay">
                                    <tr style="">
                                        <th>
                                            	선물포장
                                        </th>
                                        <td>
                                            <span class="rdb_w">
                                                <input type="radio" id="rdoGiftPackGbN" name="rdoGiftPackGb" onclick="fnSetGiftPackGb(this, 'false')" 
                                                       value="01" checked="checked" class="rdbtn" /> 안함           
                                            </span>
                                            <input type="radio" id="rdoGiftPackGbY" name="rdoGiftPackGb" value="09" onclick="fnSetGiftPackGb(this, 'true')"
                                                   class="rdbtn" /> 요청
                                            <span class="info11"> (<em class="ls0">1,000</em>원) </span>
                                            <input type="hidden" id="hdnPackFare" value="0" />
                                            <input type="hidden" id="hdnPackFareDcAmt" value="0" />
                                            <input type="hidden" id="hdnGiftPackAvailable" value="true" />
                                        </td>
                                    </tr>
                                    <tr class="GiftPackY" style="">
                                        <th>
                                            	선물메세지
                                        </th>
                                        <td>
                                            <span class="rdb_w">                      
                                                <input type="radio" id="rdoGiftMessageN" name="rdoGiftMessage"
                                                       onclick="javascript:fnTxtGiftMessageDisabledChanged(true);" class="rdbtn" checked="checked" />        
                                                	사용안함    
                                            </span>
                                            <input type="radio" id="rdoGiftMessageY" name="rdoGiftMessage"
                                                   onclick="javascript:fnTxtGiftMessageDisabledChanged(false);" class="rdbtn" /> 사용함
                                            <div id="GridPackMessage" style="display:none">
                                                <p class="nt">선물메세지 : 작성하시면, 편지지에 인쇄하여 함께 보내드립니다.</p>
                                                <p class="txt_area_w">
                                                    <textarea id="txtGiftMessage" class="txt_area" rows="4" cols="10" 
                                                              disabled="disabled" onkeyup="javascript:fnGiftMessageInfoDisplay(this, 400);">
                                                    </textarea>
                                                    <span id="spnGiftMessageInfo" class="info11">현재글자 : <strong>0</strong> / 400<br/>
                                                    </span>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <!-- 부가옵션 // -->
                            
                            <div class="btn_area">
                                <a id="btnPayment" href="#">
                                    <img src="https://secimage.yes24.com/sysimage/orderN/b_pay.gif" alt="결제하기" />
                                </a>
                            </div>
                        </div>

                        <!-- 결제 방법 선택 -->
                        <table cellpadding="0" cellspacing="0" class="tbl_pay tbl_scard">
                            <tr>
                                <th>신용카드</th>
                                <td class="dlv_mtd">
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoCardNormal" name="rdoPaymentMethod" value="01A" class="rdbtn" checked="checked" /> 
                                        	신용카드(일반)
                                    </span>
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoCardPartner" name="rdoPaymentMethod" value="01B" class="rdbtn" /> 
                                        	제휴할인카드
                                    </span>
                                </td>
                            </tr>
                            <tr style="">
                                <th>계좌이체</th>
                                <td class="dlv_mtd">
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoAccountTransfer" name="rdoPaymentMethod" value="04" class="rdbtn" /> 계좌이체 (수수료 없음)
                                    </span>
                                    <span class="rdb_w" style="">
                                        <input type="radio" id="rdoDeposit" name="rdoPaymentMethod" value="03" class="rdbtn" /> 무통장 입금
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <!--// 결제 방법 선택 -->

                        <!-- 카드사 선택 -->
                        <div id="divPayMthdCard" class="scard_w">
                            <table cellpadding="0" cellspacing="0" id="" class="tbl_pay">
                                <tr>
                                    <th>
                                        	카드사선택
                                    </th>
                                    <td>
                                        <div class="scard">
                                            <div class="selbxw">
                                                <select id="ddlCardNormal" name="SelCard" onchange='fnDdlCardChanged(this, "", "-1");' style="width: 202px;">
                                                    <option value="00" title="00" selected="selected">카드사 선택</option>
                                                    <option value="35" title="03">롯데카드</option>
                                                    <option value="03" title="03">신한카드</option>
                                                    <option value="02" title="03">국민카드</option>
                                                    <option value="04" title="03">삼성카드</option>
                                                    <option value="19" title="03">씨티카드</option>
                                                    <option value="01" title="03">BC카드/우리카드</option>
                                                    <option value="32" title="03">NH카드</option>
                                                    <option value="18" title="03">현대카드</option>
                                                    <option value="05" title="03">외환카드</option>
                                                    <option value="10" title="03">하나SK카드</option>
                                                    <option value="17" title="03">전북JB카드</option>
                                                    <option value="08" title="03">광주은행</option>
                                                    <option value="16" title="03">제주은행</option>
                                                    <option value="07" title="03">수협카드</option>
                                                    <option value="26" title="03">산업은행카드</option>
                                                    <option value="37" title="03">문화누리카드</option>
                                                    <option value="25" title="03">기타</option>
                                                </select>
                                                <select id="ddlCardPartner" onchange='fnDdlCardChanged(this, "", "-1");' style="display: none; width: 202px;">
                                                    <option value="00" title="00" selected="selected">카드사 선택</option>
                                                    <option value="35" title="03">YES24 MANIA 롯데카드</option>
                                                    <option value="04" title="03">YES24 MANIA 삼성올앳카드</option>
                                                    <option value="18" title="03">YES24 현대M카드</option>
                                                    <option value="01" title="03">YES24 우리V카드</option>
                                                    <option value="10" title="03">YES24 하나SK카드</option>
                                                    <option value="03" title="03">YES24 신한카드</option>
                                                </select>
                                                <select id="ddlCardForeign" onchange='fnDdlCardChanged(this, "", "-1");' style="display: none; width: 202px;">
                                                    <option value="00" title="00" selected="selected">카드사 선택</option>
                                                </select>
                                                <input type="hidden" id="hdnPgCode" value="" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trInstallment">
                                    <th>
                                        	할부선택
                                    </th>
                                    <td>
                                        <div class="sfreei" style="z-index: 1001">
                                            <div class="selbxw">
                                                <select id="ddlDivMon" onchange="fnDdlInterestFree()" style="width:120px;">
                                                    <option value="00" selected="selected">일시불</option>
                                                    <option value="02">02개월</option>
                                                    <option value="03">03개월</option>
                                                    <option value="04">04개월</option>
                                                    <option value="05">05개월</option>
                                                    <option value="06">06개월</option>
                                                    <option value="07">07개월</option>
                                                    <option value="08">08개월</option>
                                                    <option value="09">09개월</option>
                                                    <option value="10">10개월</option>
                                                    <option value="11">11개월</option>
                                                    <option value="12">12개월</option>
                                                    <option value="13">13개월</option>
                                                    <option value="14">14개월</option>
                                                    <option value="15">15개월</option>
                                                    <option value="16">16개월</option>
                                                    <option value="17">17개월</option>
                                                    <option value="18">18개월</option>
                                                </select>
                                            </div>
                                            <span class="info11" style="margin-left: 44px; vertical-align: bottom">(5만원 이상시 할부가능)</span>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!--// 카드사 선택 -->

                        <!-- 무통장 입금은행 -->
                        <div id="divPayMthdBankAccnt" style="display: none" class="scard_w">
                            <table cellpadding="0" cellspacing="0" id="" class="tbl_pay">
                                <tr>
                                    <th>
                                        	입금은행
                                    </th>
                                    <td>
                                        <div class="selbxw" style="width: 200px;">
                                            <select id="ddlBank" style="width: 180px;" onchange="fnChangeDdlBank(this)">
                                                <option value="00" selected="selected">입금하실 은행을 선택하세요.</option>
                                                <option value="03">기업은행</option>
                                                <option value="04">국민은행</option>
                                                <option value="05">외환은행</option>
                                                <option value="11">농협</option>
                                                <option value="20">우리은행</option>
                                                <option value="23">제일은행</option>
                                                <option value="26">신한은행</option>
                                                <option value="71">우체국</option>
                                                <option value="81">하나은행</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        	입금자
                                    </th>
                                    <td>
                                        <input type="text" id="txtPayerNm" value="" class="ipubx" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!--// 무통장 입금은행 -->
                    </div>
                </div>
        </div>
    </div>
</div>
