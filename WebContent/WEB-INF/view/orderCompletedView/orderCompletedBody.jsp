<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<DIV id=yesWrap sizcache="13" sizset="1">
	<br><br>
	<DIV id=wrapperContent sizcache="12" sizset="308">
		<DIV class=progbar sizcache="12" sizset="308">
			<H1 class=finish>
				카트 &gt; 결제 &gt; <STRONG>완료</STRONG>
			</H1>
		</DIV>
		<!--  prgress bar & 나의 계좌 // -->
		<!--// 완료 메세지 -->
		<DIV class=fns_t_w sizcache="12" sizset="315">
			<H2 class=fns_t>
				<SPAN class=msgl> 김대웅 </SPAN><SPAN class=msgr></SPAN>
			</H2>
			<P onclick="" id=txtcoupUseDAfter class=ordnum sizcache="12" sizset="315">
				[주문번호 : <STRONG sizcache="12" sizset="315">123724421</STRONG>] 결제가 안전하게 처리되었습니다.
			</P>
		</DIV>
		
		<!-- 배송지 정보 -->
		<DIV class=dlv_adrs_w sizcache="12" sizset="317">
			<H3>
				<SPAN class="tbl_t dlv_adrsinf">배송지 정보</SPAN>
			</H3>
			<DIV class=dlv_adrs_bx>
				<UL id=divNormalDlv class=dlv_l>
					<LI>받는 분 : 김대웅</LI>
					<LI class=clearfix>
						<DIV class=putAddrLiLft>주소 :</DIV>
						<DIV class=putAddrLiRgt>
							<SPAN class="putAddrArea clearfix" style="vertical-aling: middle">
							<IMG class=addr_item alt=도로명
								src="${adminBean.contextPath}/content/image/btn_putAddr02.gif" width=30 height=13> 
								<EM class=putAddrTxt></EM>
							</SPAN> 
							<SPAN class="putAddrArea putAddrGray clearfix">
							<IMG class=addr_item alt=지번 src="${adminBean.contextPath}/content/image/btn_putAddr03.gif" width=30 height=13> 
								<EM class=putAddrTxt>(100-013) 서울특별시 중구 충무로3가 충무로3가 59-13 9 해피하우스 613호</EM> </SPAN>
						</DIV>
				</UL>
			</DIV>
		</DIV>
		<!--  // 배송지 정보  -->
		
		<!--// 주문상품 -->
		<div class=fns_tbl_w sizcache="12" sizset="318">
			<h3>
				<span class="tbl_t ord_pd">주문상품</span>
			</h3>
			<table class="tbl_l fns_tbl_l" sizcache="12" sizset="318">
				<colgroup>
					<col width=70>
					<col>
					<col width=90>
					<col width=70>
					<col width=90>
				</colgroup>
				<thead>
					<tr>
						<th colSpan=2><em class=name>상품명</em></th>
						<th><em class=fpri>정가</em></th>
						<th><em class=numb>수량</em></th>
						<th><em class=tota>합계</em></th>
					</tr>
				</<thead>
				<tbody sizcache="12" sizset="318">
				<%-- 여기에 Product Data 삽입
					<tr class=last sizcache="12" sizset="318">
						<td class="goods_img le" sizcache="12" sizset="318"> 
							<img class=pdimg alt="" src="#">
						</td>
						<td class=le sizcache="12" sizset="319">
							상품명을 여기에 추가
						</td>
						<td>
							106,000원
						</td>
						<td>
							1
						</td>
						<td>
							<STRONG>95,400원</STRONG>
						</td>
					</tr>
				 --%>
				</tbody>
			</TABLE>
		</DIV>
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
						<td class="clr1"><em id="txtSaleAmount">0</em>원 <input type="hidden" id="hdnSale" value="0"></td>
						<td class="clr2"><em id="txtTotalAmount">${requestScope.orderViewInfo.totalPrice}</em>원 
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 결제정보 // -->
		<!--// 주문버튼 -->
		<div class=btn_area sizcache="12" sizset="322">
			<a href="#"> <IMG alt="마이페이지로 이동" src="${adminBean.contextPath}/content/image/b_goMypage.gif"></a>
			<a href="#"> <IMG alt="메인으로 이동" src="${adminBean.contextPath}/content/image/b_goMain.gif"></a>
		</div>
		<!-- 주문버튼 //-->
	</DIV>
	</DIV>