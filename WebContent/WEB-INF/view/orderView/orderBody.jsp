<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div id="yesWrap">
	<div id="divAjaxLoader" align="center" style="position: absolute;"></div>
    <div id="wrapperContent">
    	<br>
		<div class="progbar">
		    <h1 class="pay">카트 &gt; <strong>결제</strong> &gt; 완료</h1>
		</div>
		<div id="divGoodsOrderDetail" style="">
                <!--// 상품확인 -->
                <div id="divGoods">
                	</br></br>
                    <h3><span class='tbl_t pdchk'>상품확인</span></h3>
					<table class='tbl_l'>
                            <colgroup>
                                <col width='33' />
                                <col width='60' />
                                <col width='' />
                                <col width='90' />
                                <col width='70' />
                                <col width='90' />
                                <col width='80' />
                                <col width='96' />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th style='vertical-align:middle;'>
                                		<input type='hidden' class='chkbx' id='chkCartHeader'/>
                            		</th>
                                    <th colspan='2'><em class='name'>상품명</em>
                                    </th>
                                    <th><em class='fpri'>정가</em>
                                    </th>
                                    <th><em class='numb'>수량</em>
                                    </th>
                                    <th><em class='tota'>합계</em>
                                    </th>
                                    <th><em class='ddat'>배송일</em>
                                    </th>
                                    <th><em class='orde'>주문</em>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            <%-- 여기에 Product Data 삽입 --%>
                            </tbody>
							
                            <tfoot>
                            <%-- 여기에 Table Footer Data 삽입--%>
                            </tfoot>
                        </table>
                    <div id='divDiscount' class='dc_area' style=''>
                    </div>
	            </div>
	            <div class="graybox">
					<p class="moveBtn">
						<%-- 여기에 Button Control 추가 --%>
					</p>
					<br><br>
				</div>
				<div class="tot_price tot_price_pay">
					<table class="tbl_p" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="120">
							<col width="150">
							<col width="40">
							<col width="130">
							<col width="40">
							<col width="147">
							<col width="25">
							<col width="300">
						</colgroup>
						<tbody>
							<tr>
								<th><em class="tot1">총 상품수</em></th>
								<th><em class="tot2">총 상품금액</em></th>
								<th rowspan="2"><span class="iw tt_pl">+</span></th>
								<th><em class="tot3">총 배송비</em></th>
								<th rowspan="2"><span class="iw tt_mi">-</span></th>
								<th><em class="tot4">총 할인금액</em></th>
								<th rowspan="2"><span class="iw tt_ec">=</span></th>
								<th><em class="tot5">최종 결제금액</em></th>
							</tr>
							<tr id="summeryTotal">
								<td id="totalDesciption"><em>${requestScope.orderViewInfo.totalDescription}</em></td>
								<td id="totalItemsPrice"><em>${requestScope.orderViewInfo.productsTotalPrice}</em>원</td>
								<td id="txtTotalDelvFare"><em>${requestScope.orderViewInfo.shippingTotalPrice}</em>원</td>
								<td class="clr1">
									<em id="txtSaleAmount">0</em>원
									<input type="hidden" id="hdnSale" value="0">
								</td>
								<td class="clr2">
									<em id="txtTotalAmount">${requestScope.orderViewInfo.totalPrice}</em>원
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 상품확인 //-->

                <!-- // 배송주소 -->
                
                <div id="divDelvAddr" class="pay_w" style="">
                	</br></br>
                    <h3><span class="tbl_t dlv_address">배송주소</span></h3>
                    <div class="col2">
                        <div class="inf_mem">
                            <h4 class="tbl_t">주문고객</h4>
                            <table cellpadding="0" cellspacing="0" class="tbl_pay">
                                <tr>
                                    <th>이름</th>
                                    <td> <input type="text" id="txtMemNm" value="<c:out value="${requestScope.orderViewInfo.user.name}"/>" class="ipubx" /></td>
                                </tr>
                                <tr>
                                    <th>
                                        	핸드폰
                                    </th>
                                    <td class="num_p">
                                        <select id="ddlAddrMobNo1" style="width: 72px; margin-bottom: 1px; vertical-align: bottom">
                                            <option value="">선택</option>
                                            ${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberHeadHtml}
                                        </select> -
                                        <input type="text" id="txtAddrMobNo2" value="<c:out value="${requestScope.orderViewInfo.userPhoneNumberMid}"/>" class="ipubx" maxlength="4" /> -
                                        <input type="text" id="txtAddrMobNo3" value="<c:out value="${requestScope.orderViewInfo.userPhoneNumberTail}"/>" class="ipubx" maxlength="4" onfocus="this.select();" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        	이메일
                                    </th>
                                    <td class="eml_w">
                                        <input type="text" id="txtMemEml" value="<c:out value="${requestScope.orderViewInfo.user.email}"/>" class="ipubx" />
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
                                        <input type="radio" id="rdoDelvAddrSetModeMember" name="rdoDelvAddrSetMod" class="rdbtn" checked="checked" /> 회원정보동일
                                    </span>
                                    <span class="rdb_w">
                                        <input type="radio" id="rdoDelvAddrSetModeList" name="rdoDelvAddrSetMod" class="rdbtn" /> 주소록           
                                    </span>

                                    <span class="rdb_w">
                                        <input type="radio" id="rdoDelvAddrSetModeNew" name="rdoDelvAddrSetMod" value="NEW" class="rdbtn" /> 새로입력
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" class="tbl_pay" id="basicAddressSettings">
                            <tr id="trOrdNmNormal" style="">
                                <th>배송지명</th>
                                <td><input id="txtOrdNmNormalBasic" type="text" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.name}"/>" class="ipubx" /></td>
                            </tr>

                            <tr id="trDelvAddrNormal" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1Basic" value="<c:out value="${requestScope.orderViewInfo.basicAddressNew.postNumHeader}"/>" class="ipubx" style="width: 40px" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2Basic" value="<c:out value="${requestScope.orderViewInfo.basicAddressNew.postNumTail}"/>" class="ipubx" style="width: 40px" readonly="readonly" />
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressByStBasic" class="ipubx"
                                        	   value="<c:out value="${requestScope.orderViewInfo.basicAddressNew.basicAdd}"/>"
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOldBasic"  class="ipubx" 
                                               value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.basicAdd}"/>"
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">상세 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressDetail"  class="ipubx" 
                                               value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.detailAdd}"/>"
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p> 
                                </td>
                            </tr>

                            <tr id="trDelvMobNoNormal" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1NormalBasic" style="width: 50px; margin-bottom: 1px; vertical-align: bottom">
                                        <option value="">선택</option>
                                        ${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberHeadHtml}
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2Normal" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberMid}"/>" class="ipubx" maxlength="4"/> -
                                    <input type="text" id="txtRcvrMobTelNo3Normal" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberTail}"/>" class="ipubx" maxlength="4"/>
                                </td>
                            </tr>
                        </table>
                        
						<table cellpadding="0" class="tbl_pay"  id="newAddressSettings" style="display:none">
                            <tr id="trOrdNmNormal" style="">
                                <th>배송지명</th>
                                <td><input id="txtOrdNmNormalNew" type="text" value="" class="ipubx" /></td>
                            </tr>

                            <tr id="trDelvAddrNormal" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1New" value="" class="ipubx" style="width: 40px" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2New" value="" class="ipubx" style="width: 40px" readonly="readonly" />
                                    <a href="#" title="주소 찾기" id="aZipFind">주소 찾기   
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressByStNew" class="ipubx" 
                                               value="" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOldNew"
                                               value=""
                                               class="ipubx" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                        <a href="#" title="주소록에 추가" id="addNewAddress" class="bw add_adrs">주소록에 추가</a>
                                    </p> 
                                    <p style="line-height:20px;">상세 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressNewDetail"  class="ipubx" 
                                               value="<c:out value=""/>"
                                               style="width:320px;vertical-align:middle;" required/>
                                    </p> 
                                </td>
                                
                            </tr>

                            <tr id="trDelvMobNoNormalNew" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1NormalNew" style="width: 50px; margin-bottom: 1px; vertical-align: bottom">
                                        <option value="">선택</option>
                                        <option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option> 
										<option value="017">017</option> 
										<option value="018">018</option>
										<option value="019">019</option> 
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2NormalNew" value="" class="ipubx" maxlength="4"/> -
                                    <input type="text" id="txtRcvrMobTelNo3NormalNew" value="" class="ipubx" maxlength="4"/>
                                </td>
                            </tr>
                        </table>
						<div id="existingAddressLayer">
						<c:forEach var="addressInfo" varStatus="addressInfos" items="${requestScope.orderViewInfo.addressesPair}">
						<table cellpadding="0" class="tbl_pay"  id="existingAddressSettings<c:out value="${addressInfos.index}"/>" style="display:none">
                            <tr id="trOrdNmNormal" style="">
                                <th>배송지명</th>
                                <td><input id="txtOrdNmNormalExisting<c:out value="${addressInfos.index}"/>" type="text" value="<c:out value="${addressInfo.addressOrigin.name}"/>" class="ipubx" /></td>
                            </tr>

                            <tr id="trDelvAddrNormalExisting<c:out value="${addressInfos.index}"/>" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1Existing<c:out value="${addressInfos.index}"/>" value="<c:out value="${addressInfo.addressOrigin.postNumHeader}"/>" class="ipubx" style="width: 40px" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2Existing<c:out value="${addressInfos.index}"/>" value="<c:out value="${addressInfo.addressOrigin.postNumTail}"/>" class="ipubx" style="width: 40px" readonly="readonly" />
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressByStExisting<c:out value="${addressInfos.index}"/>" class="ipubx"
                                               value="<c:out value="${addressInfo.addressNew.fullAddress}"/>"  
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOldExisting<c:out value="${addressInfos.index}"/>"
                                               value="<c:out value="${addressInfo.addressOrigin.fullAddress}"/>"  
                                               class="ipubx" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p> 
                                </td>
                            </tr>

                            <tr id="trDelvMobNoNormalExisting<c:out value="${addressInfos.index}"/>" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1NormalExisting<c:out value="${addressInfos.index}"/>" style="width: 50px; margin-bottom: 1px; vertical-align: bottom">
                                        <option value="">선택</option>
                                        ${addressInfo.addressOrigin.phoneNumberHeadHtml}
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2NormalExisting<c:out value="${addressInfos.index}"/>" value="<c:out value="${addressInfo.addressOrigin.phoneNumberMid}"/>" class="ipubx" maxlength="4"/> -
                                    <input type="text" id="txtRcvrMobTelNo3NormalExisting<c:out value="${addressInfos.index}"/>" value="<c:out value="${addressInfo.addressOrigin.phoneNumberTail}"/>" class="ipubx" maxlength="4"/>
                                </td>
                            </tr>
                        </table>
                        </c:forEach>
                        </div>
                    </div>
                </div>
                <!-- 배송주소 // -->
                <!-- // 결제방법 -->
                <div class="pay_w">
                    <h3><span class="tbl_t paym_t" id="lblOrderPaymentMethodTitle">결제방법</span></h3>
                    <div class="col2">
                        <div class="added_w" id="divPayMethodValues" style="">

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
                            <!-- 결제버튼 -->
                            <div class="btn_area">
								<div id="divAjaxLoaderOrder" style="position: absolute; height: 80px; width: 200px; display: none;">
									<img src="${adminBean.contextPath}/content/image/pay_loading.gif" style="padding-left: 40px; height: 80px; width: 200px; margin-left:15px; margin-top:-10px" id="imgAjaxLoaderOrder" />
								</div>
								<a id="btnPayment" href="showOrderCompletedView">
	                                <img src="${adminBean.contextPath}/content/image/b_pay.gif" alt="결제하기" />
	                            </a>
                            </div>
                            <!-- 결제버튼// -->
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
                                                <select id="ddlCardNormal" name="SelCard" style="width: 202px;">
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
                                                <select id="ddlCardPartner" style="display: none; width: 202px;">
                                                    <option value="00" title="00" selected="selected">카드사 선택</option>
                                                    <option value="35" title="03">ShShop MANIA 롯데카드</option>
                                                    <option value="04" title="03">ShShop MANIA 삼성올앳카드</option>
                                                    <option value="18" title="03">ShShop 현대M카드</option>
                                                    <option value="01" title="03">ShShop 우리V카드</option>
                                                    <option value="10" title="03">ShShop 하나SK카드</option>
                                                    <option value="03" title="03">ShShop 신한카드</option>
                                                </select>
                                                <select id="ddlCardForeign" style="display: none; width: 202px;">
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

						<!--  계좌이체 안내 -->
						<div id="divPayMthdBankRTime" class="scard_w">
						<table cellpadding="0" cellspacing="0" id="" class="tbl_pay">
							<tbody>
								<tr>
									<th>계좌이체<br>안내
									</th>
									<td>
										<ul class="smsg_l">
											<li>계좌이체 플러그인이 설치안되어 있는 경우 설치 후 결제 <a href="javascript:"
												onclick="window.open('http://pg.banktown.com/wallet/common/plugin_check.html', '', 'width=340, height=430'); return false;" title="파일 받기"
												class="bw rfile">파일 받기</a></li>
											<li>결제금액이 입력하신 계좌에서 자동으로 이체되는 서비스로 계좌이체시 본인인증 필요.(법인/개인사업자 계좌는 불가능) <a href="javascript:"
												onclick="fnShowYesLayerPop('divCertificationInfo', this); return false;" title="본인 인증 안내" class="bw ifo_ctfc">본인 인증 안내</a></li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						<!--  //계좌이체 안내 -->

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
                    <!-- 주소록 (숨기기)-->
                    <div id="divAddressList" class="plyr" style="position: absolute; z-index: 99999; width: 700px; left: 206px; top: 10000px;">
					    <div class="plyr_w">
					        <div id="divAddressListMember" class="plyr_c" style="width: 700px;">
					            <ul class="plyr_l">
					                <li>
					                   ${requestScope.orderViewInfo.user.name} 의 주소록(<strong>${requestScope.orderViewInfo.addressesPairSize}</strong>) ( 최대 5개까지 등록 가능 )
					                </li>
					            </ul>
					            <table class="tbl_l" id="addressInfoTable">
					                <colgroup>
					                    <col width="34">
					                    <col width="60">
					                    <col width="60">
					                    <col width="">
					                    <col width="100">
					                    <col width="90">
					                </colgroup>
					                <thead>
					                    <tr>
					                        <th colspan="2">
					                            <em class="recia">수령지</em>
					                        </th>
					                        <th>
					                            <em class="reci">수령자</em>
					                        </th>
					                        <th>
					                            <em class="dlva">배송지</em>
					                        </th>
					                        <th>
					                            <em class="mobi">휴대폰</em>
					                        </th>
					                        <th>
					                            <em class="mana">관리</em>
					                        </th>
					                    </tr>
					                </thead>
					                <tbody>
										<c:forEach var="addressInfo" varStatus="addressInfos" items="${requestScope.orderViewInfo.addressesPair}">
										<tr id="addressInfoItem<c:out value="${addressInfos.index}"/>">
					                        <td valign="top">
					                            <input type="checkbox" 
							                           id="chkMemberAddress<c:out value="${addressInfos.index}"/>" 
							                           name="chkMemberAddress" 
							                           value="${addressInfos.index}"  
							                           class="chkbx">
					                        </td>
					                        <td valign="top">
					                            <a href="#" id="memberAddressName<c:out value="${addressInfos.index}"/>">${addressInfo.addressOrigin.name}</a>
					                        </td>
					                        <td valign="top">
					                           	 ${requestScope.orderViewInfo.user.name}
					                        </td>
					                        <td class="le" valign="top">
					                            <div class="putAddrWrap">
					                                <div class="putAddrLft">
					                                    <img class="addr_item" src="${adminBean.contextPath}/content/image/btn_putAddr02.gif" 
					                                        width="30" height="13" alt="도로명">
					                                </div>
					                                <div class="putAddrRgt">
					                                    <span class="putAddrTxt">
					                                        <a href="#" id="memberZipCodeNew<c:out value="${addressInfos.index}"/>">
					                                        (<c:out value="${addressInfo.addressNew.postNumHeader}"/>-
					                                        <c:out value="${addressInfo.addressNew.postNumTail}"/>)
					                                        <c:out value="${addressInfo.addressNew.fullAddress}"/>
					                                        </a>
					                                    </span>
					                                </div>
					                            </div>
					                            <div class="putAddrWrap mgt5">
					                                <div class="putAddrLft">
					                                    <img class="addr_item" src="${adminBean.contextPath}/content/image/btn_putAddr03.gif" width="30" height="13" alt="지번">
					                                </div>
					                                <div class="putAddrRgt">
					                                    <span class="putAddrTxt grayTxt">
					                                        <a class="grayTxt" href="#" 
					                                           id="memberZipCode<c:out value="${addressInfos.index}"/>">
					                                        (<c:out value="${addressInfo.addressOrigin.postNumHeader}"/>-
					                                        <c:out value="${addressInfo.addressOrigin.postNumTail}"/>)
					                                        <c:out value="${addressInfo.addressOrigin.fullAddress}"/>
					                                        </a>
					                                    </span>
					                                </div>
					                            </div>
					                        </td>
					                        <td valign="top"  id="memberPhoneNumber<c:out value="${addressInfos.index}"/>">
					                            ${addressInfo.addressOrigin.phoneNumber}
					                        </td>
					                        <td valign="top">
					                            <a href="#"  id="addressDelete<c:out value="${addressInfos.index}"/>" title="삭제하기" class="bw delet_s">삭제하기</a>
					                            <a href="#"  id="addressModify<c:out value="${addressInfos.index}"/>" title="수정" class="bw modif">수정</a>
					                        </td>
					                    </tr>
										</c:forEach>
					                </tbody>
					            </table>
					            <div class="btn_area_p">
					                <a href="#" class="bw sel_add_use" id="addrChooser" title="선택 주소 사용">선택주소사용</a>
					            </div>
					        </div>
					        <div>
					            <a href="javascript:fnLayerHideById('divAddressList');" title="닫기" class="close">닫기</a>
					        </div>
					    </div>
					</div>
                    <!--// 주소록 -->
                    <!-- 주소정보 수정 -->
                    <c:forEach var="addressInfo" varStatus="addressInfos" items="${requestScope.orderViewInfo.addressesPair}">
				    <div id="divAddressNew<c:out value="${addressInfos.index}"/>" class="plyr" style="position: absolute; z-index: 99998; width: 586px; display:none;">
					    <div class="plyr_w">
					        <h3 id="lblAddressNewTitle<c:out value="${addressInfos.index}"/>" class="plyr_t">주소정보 수정</h3>
					        <div class="plyr_c" style="width: 550px;">
					            <table class="tbl_nbk sel_c2">
					                <colgroup>
					                    <col width="90"><col width="">
					                </colgroup>
					                <tbody><tr>
					                    <th>주소이름</th>
					                    <td>
					                        <input type="text" id="txtAddrNickNew<c:out value="${addressInfos.index}"/>" value="김대웅" class="ipubx" style="width: 150px;">
					                        <input type="hidden" id="hdnAddrSeq<c:out value="${addressInfos.index}"/>" value="5">
					                    </td>
					                </tr>
					                <tr id="divAddressNewKorea">
					                    <th>주소</th>	
										<td>
											<input type="text" id="txtZipCd1New<c:out value="${addressInfos.index}"/>" 
												   value="<c:out value="${addressInfo.addressOrigin.postNumHeader}"/>" readonly="readonly" class="ipubx" style="width:30px"> - 
											<input type="text" id="txtZipCd2New<c:out value="${addressInfos.index}"/>" value="<c:out value="${addressInfo.addressOrigin.postNumTail}"/>" readonly="readonly" class="ipubx" style="width:30px"> 
											<a id="aZipFinderSub<c:out value="${addressInfos.index}"/>" href="#" title="주소 찾기" class="bw sch_address">주소 찾기</a><br>
											<p style="margin:5px 0">
												도로명 주소 <input type="text" id="txtAddressNewBySt<c:out value="${addressInfos.index}"/>" 
																  value="<c:out value="${addressInfo.addressNew.basicAdd}"/>" 
																  class="ipubx" style="width:300px;" readonly="readonly">
											</p>
											<p style="margin-bottom:5px;">
												지번 주소&nbsp;&nbsp;&nbsp; 
												<input type="text" id="txtAddressNewByOld<c:out value="${addressInfos.index}"/>" 
													   value="<c:out value="${addressInfo.addressOrigin.basicAdd}"/>"
													   class="ipubx" style="width:300px;" readonly="readonly">
											</p>
											<p style="margin-bottom:5px;">
												상세 주소&nbsp;&nbsp;&nbsp; 
												<input type="text" id="txtAddressDetail<c:out value="${addressInfos.index}"/>" 
													   value="<c:out value="${addressInfo.addressOrigin.detailAdd}"/>"
													   class="ipubx" style="width:300px;">
											</p>
										</td>	
					                </tr>              
					                <tr>
					                    <th>핸드폰</th>
					                    <td>
					                        <input type="text" id="txtMobNoNew<c:out value="${addressInfos.index}"/>" 
					                        	   value="<c:out value="${addressInfo.addressOrigin.phoneNumber}"/>" 
					                        	   class="ipubx" style="width: 110px;">
					                    </td>
					                </tr>
					                <tr>
					                <td colspan="2">
					                    <div id="divAddressNewBtn" class="btn_area_p" style="z-index: 99999;">
					                        <a href="#" id="btnAddrModify<c:out value="${addressInfos.index}"/>" class="bw cfrm" title="확인">확인</a>
					                        <a href="javascript:fnPopupLayerHide('divAddressNew');" id="btnAddrModifyCancel" class="bw cnl" title="취소">취소</a>
					                    </div>
					                </td>
					                </tr>
					            </tbody></table>
					        </div>
					        <div>
					            <a href="javascript:fnLayerHideById('divAddressNew<c:out value="${addressInfos.index}"/>');" title="닫기" class="close">닫기</a>
					        </div>
					    </div>
					</div>
					</c:forEach>
			</div>
        </div>
    </div>
</div>

