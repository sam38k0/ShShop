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
 
						<c:forEach var="orderInfo" varStatus="orderInfos" items="${requestScope.orderViewInfo.orderInfos}">
						<tr class='last'>
                                <td class='goods_img le'>
                                    <a href='http://www.yes24.com/24/Goods/18242263' class='pd_a' target='_blank'>
                                        <img src="<c:out value="${adminBean.contextPath}"/><c:out value="${orderInfo.imagePath}"/> " alt='' class='pdimg' target='_blank' />
                                    </a>
                                </td>
                                <td>
                                    <a href='http://www.yes24.com/24/Goods/18242263' class='pd_a'>${orderInfo.product.name}</a>
                                </td>
                                <td>
                                    ${orderInfo.product.price}
                                </td>
 
                                <td>
                                    ${orderInfo.quantity}
                                </td>
                                <td><strong> ${orderInfo.price}원</strong>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id='divDiscount' class='dc_area' style=''>
                    </div>
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
								<th><em class="tot1">총 상품수s</em></th>
								<th><em class="tot2">총 상품금액</em></th>
								<th rowspan="2"><span class="iw tt_pl">+</span></th>
								<th><em class="tot3">총 배송비</em></th>
								<th rowspan="2"><span class="iw tt_mi">-</span></th>
								<th><em class="tot4">총 할인금액</em></th>
								<th rowspan="2"><span class="iw tt_ec">=</span></th>
								<th><em class="tot5">최종 결제금액</em></th>
							</tr>
							<tr>
								<td>${requestScope.orderViewInfo.totalDescription}</td>
								<td><em>${requestScope.orderViewInfo.productsTotalPrice}</em>원</td>
								<td><em id="txtTotalDelvFare">${requestScope.orderViewInfo.shippingTotalPrice}</em>원</td>
								<td class="clr1">
									<em id="txtSaleAmount">0</em>원
									<input type="hidden" id="hdnYes24Sale" value="0">
								</td>
								<td class="clr2">
									<em id="txtTotalAmount">${requestScope.orderViewInfo.totalPrice}</em>원
									<span id="spnGiftPackGbMemo2" class="wfee" display="none" style="display: none;">
										(선물포장비 <strong class="ls0">1,000원</strong> 포함)
									</span>
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
                                            ${requestScope.orderViewInfo.phoneNumberHeadHtml}
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
                                <th>이름</th>
                                <td><input id="txtOrdNmNormal" type="text" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.name}"/>" class="ipubx" /></td>
                            </tr>

                            <tr id="trDelvAddrNormal" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1" value="100" class="ipubx" style="width: 40px" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2" value="013" class="ipubx" style="width: 40px" readonly="readonly" />
                                    <a href="#" title="주소 찾기" id="aZipFind">주소 찾기   
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressBySt" class="ipubx" onblur="fnAddressModifyApply();" 
                                               value="<c:out value="${requestScope.orderViewInfo.basicAddressNew.basicAdd} "/><c:out value="${requestScope.orderViewInfo.basicAddressNew.detailAdd}"/>" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOld" onblur="fnAddressModifyApply();" 
                                               value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.basicAdd} "/><c:out value="${requestScope.orderViewInfo.basicAddressOrigin.detailAdd}"/>"
                                               class="ipubx" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                        <a href="#" title="주소록에 추가" class="bw add_adrs">주소록에 추가</a>
                                    </p> 
                                </td>
                            </tr>

                            <tr id="trDelvMobNoNormal" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1Normal" style="width: 50px; margin-bottom: 1px; vertical-align: bottom">
                                        <option value="">선택</option>
                                        <option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option> 
										<option value="017">017</option> 
										<option value="018">018</option>
										<option value="019">019</option> 
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2Normal" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberMid}"/>" class="ipubx" maxlength="4"/> -
                                    <input type="text" id="txtRcvrMobTelNo3Normal" value="<c:out value="${requestScope.orderViewInfo.basicAddressOrigin.phoneNumberTail}"/>" class="ipubx" maxlength="4"/>
                                </td>
                            </tr>
                        </table>
                        
                        
						<table cellpadding="0" class="tbl_pay"  id="newAddressSettings" style="display:none">
                            <tr id="trOrdNmNormal" style="">
                                <th>이름</th>
                                <td><input id="txtOrdNmNormal" type="text" value="" class="ipubx" /></td>
                            </tr>

                            <tr id="trDelvAddrNormal" style="">
                                <th>
                                  	  배송주소
                                </th>
                                <td>
                                    <input type="text" id="txtZipCode1" value="100" class="ipubx" style="width: 40px" readonly="readonly" /> -
                                    <input type="text" id="txtZipCode2" value="013" class="ipubx" style="width: 40px" readonly="readonly" />
                                    <a href="#" title="주소 찾기" id="aZipFind">주소 찾기   
                                    </a>
                                    <br/>
                                    <p style="margin:5px 0;">도로명 주소
                                        <input type="text" id="txtAddressBySt" class="ipubx" onblur="fnAddressModifyApply();" 
                                               value="" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                    </p>
                                    <p style="line-height:20px;">지번 주소&nbsp;&nbsp;&nbsp;
                                        <input type="text" id="txtAddressByOld" onblur="fnAddressModifyApply();" 
                                               value=""
                                               class="ipubx" 
                                               style="width:320px;vertical-align:middle;" readonly="readonly" />
                                        <a href="#" title="주소록에 추가" class="bw add_adrs">주소록에 추가</a>
                                    </p> 
                                </td>
                            </tr>

                            <tr id="trDelvMobNoNormal" style="">
                                <th>
                                   	 핸드폰
                                </th>
                                <td class="num_p" style="height: 22px;">
                                    <select id="ddlRcvrMobTelNo1Normal" style="width: 50px; margin-bottom: 1px; vertical-align: bottom">
                                        <option value="">선택</option>
                                        <option value="010" selected="selected">010</option>
										<option value="011">011</option>
										<option value="016">016</option> 
										<option value="017">017</option> 
										<option value="018">018</option>
										<option value="019">019</option> 
                                    </select> -
                                    <input type="text" id="txtRcvrMobTelNo2Normal" value="" class="ipubx" maxlength="4"/> -
                                    <input type="text" id="txtRcvrMobTelNo3Normal" value="" class="ipubx" maxlength="4"/>
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
					            <table class="tbl_l">
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
										<tr>
					                        <td valign="top">
					                            <input type="checkbox" id="chkMemberAddress5" name="chkMemberAddress" value="${addressInfos.index}"  class="chkbx">
					                        </td>
					                        <td valign="top">
					                            <a href="#" >${addressInfo.addressOrigin.name}</a>
					                        </td>
					                        <td valign="top">
					                           	 ${requestScope.orderViewInfo.user.name}
					                        </td>
					                        <td class="le" valign="top">
					                            <div class="putAddrWrap">
					                                <div class="putAddrLft">
					                                    <img class="addr_item" src="https://secimage.yes24.com/sysimage/orderN/btn_putAddr02.gif" 
					                                        width="30" height="13" alt="도로명">
					                                </div>
					                                <div class="putAddrRgt">
					                                    <span class="putAddrTxt">
					                                        <a href="#" >
					                                        (<c:out value="${addressInfo.addressNew.postNumHeader}"/>-
					                                        <c:out value="${addressInfo.addressNew.postNumHeader}"/>)
					                                        <c:out value="${addressInfo.addressNew.basicAdd}"/>
					                                        <c:out value="${addressInfo.addressNew.detailAdd}"/>
					                                        </a>
					                                    </span>
					                                </div>
					                            </div>
					                            <div class="putAddrWrap mgt5">
					                                <div class="putAddrLft">
					                                    <img class="addr_item" src="https://secimage.yes24.com/sysimage/orderN/btn_putAddr03.gif" width="30" height="13" alt="지번">
					                                </div>
					                                <div class="putAddrRgt">
					                                    <span class="putAddrTxt grayTxt">
					                                        <a class="grayTxt" href="#" >
					                                        (<c:out value="${addressInfo.addressOrigin.postNumHeader}"/>-
					                                        <c:out value="${addressInfo.addressOrigin.postNumHeader}"/>)
					                                        <c:out value="${addressInfo.addressOrigin.basicAdd}"/>
					                                        <c:out value="${addressInfo.addressOrigin.detailAdd}"/>
					                                        </a>
					                                    </span>
					                                </div>
					                            </div>
					                        </td>
					                        <td valign="top">
					                            ${addressInfo.addressOrigin.phoneNumber}
					                        </td>
					                        <td valign="top">
					                            <a href="#"  title="삭제하기" class="bw delet_s">삭제하기</a>
					                            <a href="#"  title="수정" class="bw modif">수정</a>
					                        </td>
					                    </tr>
										</c:forEach>
					                </tbody>
					            </table>
					            <div class="btn_area_p">
					                <a href="#" class="bw sel_add_use" title="선택 주소 사용">선택주소사용</a>
					            </div>
					        </div>
					        <div>
					            <a href="javascript:fnLayerHideById('divAddressList');" title="닫기" class="close">닫기</a>
					        </div>
					    </div>
					</div>
                    <!--// 주소록 -->
                    <!-- 주소정보 수정 -->
				    <div id="divAddressNew" class="plyr" style="position: absolute; z-index: 9998; width: 586px; left: 263px; top: 500px;">
				    <div class="plyr_w">
				        <h3 id="lblAddressNewTitle" class="plyr_t">주소정보 수정</h3>
				        <div class="plyr_c" style="width: 550px;">
				            <table class="tbl_nbk sel_c2">
				                <colgroup>
				                    <col width="90"><col width="">
				                </colgroup>
				                <tbody><tr>
				                    <th>주소별칭</th>
				                    <td>
				                        <input type="text" id="txtAddrNickNew" value="김대웅" class="ipubx" style="width: 150px;">
				                        <input type="hidden" id="hdnAddrSeq" value="5">
				                    </td>
				                </tr>
				                <tr id="divAddressNewKorea">
				                    <th>주소</th>	
									<td>
										<input type="text" id="txtZipCd1New" value="100" readonly="readonly" class="ipubx" style="width:30px"> - <input type="text" id="txtZipCd2New" value="013" readonly="readonly" class="ipubx" style="width:30px"> <a id="aZipFind2" href="javascript:void(0)" onclick="LoadAddrModifyPostalCode('aZipFind2'); return false;" title="주소 찾기" class="bw sch_address">주소 찾기</a><br>
										<p style="margin:5px 0">
											도로명 주소 <input type="text" id="txtAddressNewBySt" value="서울특별시 중구 수표로 10, 9 해피하우스 602호 (충무로3가)" class="ipubx" style="width:300px;" readonly="readonly">
										</p>
										<p style="margin-bottom:5px;">
											지번 주소&nbsp;&nbsp;&nbsp; <input type="text" id="txtAddressNewByOld" value="서울특별시 중구 충무로3가 59-13 9 해피하우스 602호 " class="ipubx" style="width:300px;" readonly="readonly">
										</p>
									</td>	
				                </tr>
				                <tr id="divAddressNewForeign" style="display: none;">
				                    <th>주소</th>
				                    <td>
				                        <input type="text" id="txtZipCdNew" value="" class="ipubx">
				                        <input type="text" id="txtAddr1NewForeign" value="서울특별시 중구 충무로3가 59-13" class="ipubx" style="width: 300px;">
				                    </td>
				                </tr>
				                <tr id="divAddress2NewForeign" style="display: none;">
				                <th>상세주소</th>
				                    <td>
				                        <input type="text" id="txtAddr2NewForeign" value="9 해피하우스 602호 " class="ipubx" style="width: 300px;">
				                    </td>
				                </tr>                
				                <tr>
				                    <th>핸드폰</th>
				                    <td>
				                        <input type="text" id="txtMobNoNew" value="010-3224-0196" class="ipubx" style="width: 110px;">
				                    </td>
				                </tr>
				                <tr>
				                <td colspan="2">
				                    <div id="divAddressNewBtn" class="btn_area_p" style="z-index: 99999;">
				                        <a href="javascript:" id="btnAddrModify" onclick="fnDelvAddrModify(); return false;" class="bw cfrm" title="확인">확인</a>
				                        <a href="javascript:fnPopupLayerHide('divAddressNew');" id="btnAddrModifyCancel" class="bw cnl" title="취소">취소</a>
				                    </div>
				                </td>
				                </tr>
				            </tbody></table>
				        </div>
				        <div>
				            <a href="javascript:fnLayerHideById('divAddressNew');" title="닫기" class="close">닫기</a>
				        </div>
				    </div>
				</div>
				<!-- //주소정보 수정 -->
			</div>
        </div>
    </div>
</div>

