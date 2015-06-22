<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>
	<div id="divAjaxLoader" align="center" style="position: absolute;"></div>
    <div id="CartWrap">
        <div id="wrapperContent">   
 			</br></br>
 			
            <!-- // 장바구니 -->
            <form name="frmCartList" method="post" action="" id="frmCartList" onkeydown="if (event.keyCode == 13) return false;">
                <div id="divCart">
                    <div class='tbl_w cartTopItem'>
                    	 <h3><span class='tbl_t gen'>일반카트</span></h3>
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
                                		<input type='checkbox' class='chkbx' id='chkCartHeader'/>
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
                            	<c:forEach var="orderInfo" varStatus="orderInfos" items="${requestScope.orderViewInfo.orderInfos}">
                                <tr id='orderItemList<c:out value="${orderInfos.index}"/>'>
                                    <td class='cb'>
                                        <input type='checkbox' class='chkbx' name='chkCartGoodsShShop' id='chkCartGoodsShShop<c:out value="${orderInfos.index}"/>'/>
                                    </td>
                                    <td class='goods_img'>
                                        <a href='#' target='_new' class='pd_a'>
                                            <img src="<c:out value="${adminBean.contextPath}"/><c:out value="${orderInfo.imagePath}"/>" alt='' class='pdimg'/>
                                        </a>
                                    </td>
                                    <td class='le'>
                                       <a href='#' class='pd_a'>${orderInfo.product.name}</a>
                                        &nbsp;
                                    </td>
                                    <td>${orderInfo.product.price}원</td>
                                    <td>
                                        <input type='number' id='txtGoodsCnt<c:out value="${orderInfos.index}"/>' name='txtGoodsCnt' value="<c:out value="${orderInfo.quantity}"/>" class='ipubx num' maxlength='4' />
                                        <br/>
                                        <input type='hidden' name='hdnOriginalGoodsCnt' value='1' class='ipubx num' /><a href='#' id='hdnOriginalGoodsCnt<c:out value="${orderInfos.index}"/>' title='변경' class='bw chgnum'>변경</a>
                                    </td>
                                    <td><strong id='totalPricOfItem<c:out value="${orderInfos.index}"/>' value='${orderInfo.price}'>${orderInfo.price}원</strong>
                                    </td>
                                    <td>
                                        <p class='dvmsg'>1일 이내 <br/>배송예정</p>
                                    </td>
                                    <td class='goods_order'>
                                        <p class='ordbtnw'>
                                        <a href='#' title='주문하기' id='orderItem<c:out value="${orderInfos.index}"/>' class='bw ordpd'>주문하기</a>
                                        <a href='#' title='삭제하기' id='deleteItem<c:out value="${orderInfos.index}"/>' class='bw pddel'>삭제하기</a>
                                        </p>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan='9' class='tot'>일반카트 상품 총 금액 : 
                                        <strong id='lblTotalAmountCart'>${requestScope.orderViewInfo.productsTotalPrice}원</strong>
                                        <span class='dvi'> | </span>
                                        ShShop포인트 총 적립액 : <strong id='lblTotalPointCart'>1,220원</strong> 
                                        <span id='spnTotalPointDetailCart'>(기본 : 1,220원)</span>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
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
								<tr>
									<td id="totalDesciption"><em>${requestScope.orderViewInfo.totalDescription}</em></td>
									<td id="totalItemsPrice"><em>${requestScope.orderViewInfo.productsTotalPrice}</em>원</td>
									<td id="txtTotalDelvFare"><em>${requestScope.orderViewInfo.shippingTotalPrice}</em>원</td>
									<td class="clr1">
										<em id="txtSaleAmount">0</em>원
										<input type="hidden" id="hdnSale" value="0">
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

                    <div class='btn_area'>
                        <a href='#'><img id='btnOrderCart' src='${adminBean.contextPath}/content/image/b_order.gif' alt='주문하기' /></a>
                        <a href='#'><img src='${adminBean.contextPath}/content/image/b_goshopping.gif' alt='쇼핑계속하기' /></a>
                    </div>
                </div>
            </form>
        </div>

    </div>