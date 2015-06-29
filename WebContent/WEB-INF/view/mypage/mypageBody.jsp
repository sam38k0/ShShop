<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<div class="myroomWrap">
	<!-- TAB -->
	<br> <br>
	<div id="divAjaxLoader" align="center" style="position: absolute;"></div>
	<ul class="tabMyroom" id="tab_menu">
		<li class="on" id="idDealInfo"><a href="#" >거래정보</a></li>
		<li id="idPersonalInfo"><a href="#" >개인정보</a></li>
	</ul>
	<div class="myroomWrap2">
		<div class="deal_left">
			<div class="myroomMenuWrap">
				<div class="depth1">등록현황</div>
				<ul id="left_menu_group" class="depth2">
					<li class="first on">판매아이템
						<ul class="depth3">
							<li class="on" id="idGoodsforSelling1"><a href="#">- 전체
							<c:choose>
								<c:when test="${myProudctsItemCount != null}">
									<span>${myProudctsItemCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>
							</a></li>
							<li id="idGoodsforSelling2"><a href="#">- 판매중
							<c:choose>
								<c:when test="${myProudctsItemCountHasStock != null}">
									<span>${myProudctsItemCountHasStock}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>
							</a></li>
							<li id="idGoodsforSelling3"><a href="#">- 판매완료
							<c:choose>
								<c:when test="${myProudctsItemCountNoStock != null}">
									<span>${myProudctsItemCountNoStock}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>		
							</a></li>
						</ul>
					</li>
				</ul>
				<div class="depth1">구매현황</div>
				<ul id="left_menu_group" class="depth2">
					<li class="first on">구매아이템
						<ul class="depth3">
							<li id="idGoodsforBuying1"><a href="#">- 전체
							<c:choose>
								<c:when test="${totalOrderCount != null}">
									<span>${totalOrderCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>		
							</a></li>
							<li id="idGoodsforBuying2"><a href="#">- 입금완료 상품
							<c:choose>
								<c:when test="${sendedEmailOrderCount != null}">
									<span>${sendedEmailOrderCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>		
							</a></li>
							<li id="idGoodsforBuying3"><a href="#">- 배송중 상품<span>0건</span></a></li>
							<li id="idGoodsforBuying4"><a href="#">- 구매확정 상품<span>0건</span></a></li>
						</ul>				
					</li>
				</ul>
				<div class="depth1">배송현황</div>
				<ul id="left_menu_group" class="depth2">
					<li class="first on">배송아이템
						<ul class="depth3">
							<li id="idGoodsforDelivery1"><a href="#">- 전체
							<c:choose>
								<c:when test="${sellOrderTotalCount != null}">
									<span>${sellOrderTotalCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>		
							</a></li>
							<li id="idGoodsforDelivery2"><a href="#">- 배송할 상품
							<c:choose>
								<c:when test="${sellOrderNotDeliveredCount != null}">
									<span>${sellOrderNotDeliveredCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>	
							</a></li>
							<li id="idGoodsforDelivery3"><a href="#">- 배송된 상품
							<c:choose>
								<c:when test="${sellOrderDeliveredCount != null}">
									<span>${sellOrderDeliveredCount}건</span>
								</c:when>
								<c:otherwise>
									<span>0건</span>
								</c:otherwise>
							</c:choose>	
							</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="deal_rigth">
			<div id="wrapperContent" style="display:none">
				<div style="position: relative; height: 25px;">
					<div style="position: absolute"></div>
				</div>
				<table width="960" cellpadding="0" cellspacing="0" align="center">
					<tr>
						<td width="187" valign="top">
							<%-- 							
							<div class="periodBox">
								<div class="period clearfix" id="divPeriodDefault">
									<span class="periodBtn fl"> 
										<a href="#"><img id="imgDefault1d" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1d.gif" alt="당일"></a> 
										<a href="#"><img id="imgDefault1w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1w.gif" alt="1주"></a> 
										<a href="#"><img id="imgDefault2w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2w.gif" alt="2주"></a> 
										<a href="#"><img id="imgDefault1m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1m.gif" alt="1개월"></a> 
										<a href="#"><img id="imgDefault2m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2m.gif" alt="2개월"></a> 
										<a href="#"><img id="imgDefault3m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_3m.gif" alt="3개월"></a> 
										<a href="#"><img id="imgDefault4m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_4mOn.gif" alt="4개월"></a>
									</span> 
									<span class="fl">&nbsp;까지 조회 </span>
								</div>
							</div> <br/> 
							--%>
							<table cellpadding="0" border="0" width="750">
								<tr>
									<td width="750" height="3" bgcolor="#7CBBDE"></td>
								</tr>
								<tr>
									<td width="750" height="2" bgcolor="#FFFFFF">
									<td>
								</tr>
								<tr>
									<td width="750" height="1" bgcolor="#C9C9C9">
									<td>
								</tr>
								<tr>
									<td width="750" id="tdOrderList">
										<table cellpadding='0' border='0' width='750'>
											<tr>
												<td colspan='2' width='750' bgcolor='#FFFFFF'>
													<table id='idMyOrderListTbl' cellpadding='0' cellspacing='0' border='0' width='750'>
														<thead>
															<tr>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>주문번호</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>주문일자</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='295' height='32' align='center' class='infoGray'>주문내역</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='100' height='32' align='center' class='infoGray'>주문금액/수량</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>주문상태</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='75' height='32' align='center' class='infoGray'>판매자</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='1' height='32'></td>
																<td bgcolor='#F2F2F2' width='70' height='32' align='center' class='infoGray'>배송관리</td>
                                                            	
															</tr>
															<tr>
																<td height='1' bgcolor='#E8E8E8' colspan='15'></td>
															</tr>
														</thead>
														<tbody>
															<!-- 여기에 구매한 상품 정보를 삽입 -->
														</tbody>
													</table>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='2' bgcolor='#FFFFFF'>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='1' bgcolor='#C9C9C9'>
												<td>
											</tr>
											<tr>
												<td height='10'></td>
											</tr>
										</table>
									<td>
								</tr>
								<tr>
									<td class="InfoGray" height="30" valign="middle">
										<div class="graybox"><p class="moveBtn" id="idMoveBtnForOrders"> </p></div>
										<div style="margin-top: 10px;">
											- 발송 전 주문은 <span style="color: #3A85C7;">주문취소</span>가 가능합니다. <br>
										</div>
										<div style="margin-top: 10px;">- 주문번호를 클릭하시면 주문상세내역을 확인하실수 있습니다.</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="wrapperContent2">
				<div style="position: relative; height: 25px;">
					<div style="position: absolute"></div>
				</div>
				<table width="960" cellpadding="0" align="center">
					<tr>
						<td width="187" valign="top">
							<%-- 							
							<div class="periodBox">
								<div class="period clearfix" id="divPeriodDefault">
									<span class="periodBtn fl"> 
										<a href="#"><img id="imgDefault1d" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1d.gif" alt="당일"></a> 
										<a href="#"><img id="imgDefault1w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1w.gif" alt="1주"></a> 
										<a href="#"><img id="imgDefault2w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2w.gif" alt="2주"></a> 
										<a href="#"><img id="imgDefault1m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1m.gif" alt="1개월"></a> 
										<a href="#"><img id="imgDefault2m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2m.gif" alt="2개월"></a> 
										<a href="#"><img id="imgDefault3m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_3m.gif" alt="3개월"></a> 
										<a href="#"><img id="imgDefault4m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_4mOn.gif" alt="4개월"></a>
									</span> 
									<span class="fl">&nbsp;까지 조회 </span>
								</div>
							</div> <br/> 
							--%>
							<table cellpadding="0" border="0" width="750">
								<tr>
									<td width="750" height="3" bgcolor="#7CBBDE"></td>
								</tr>
								<tr>
									<td width="750" height="2" bgcolor="#FFFFFF">
									<td>
								</tr>
								<tr>
									<td width="750" height="1" bgcolor="#C9C9C9">
									<td>
								</tr>
								<tr>
									<td width="750" id="tdOrderList">
										<table cellpadding='0' border='0' width='750'>
											<tr>
												<td colspan='2' width='750' bgcolor='#FFFFFF'>
													<table id='idMyProductsListTbl' cellpadding='0' cellspacing='0' border='0' width='750'>
														<thead>
															<tr>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>게시번호</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='295' height='32' align='center' class='infoGray'>제목</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>가격</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='100' height='32' align='center' class='infoGray'>히트수</td>
																<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
																<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>등록일</td>
															</tr>
															<tr>
																<td height='1' bgcolor='#E8E8E8' colspan='15'></td>
															</tr>
														<thead>
														<tbody>
														<!-- 여기에 상품 정보를 기입 -->
														</tbody>
													</table>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='2' bgcolor='#FFFFFF'>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='1' bgcolor='#C9C9C9'>
												<td>
											</tr>
											<tr>
												<td height='10'></td>
											</tr>
										</table>
									<td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<div class="graybox"><p class="moveBtn" id="idMoveBtnForProducts"> </p><br><br></div>
			</div>
			
			<div id="wrapperContent3" style="display:none">
				<div style="position: relative; height: 25px;">
					<div style="position: absolute"></div>
				</div>
				<table width="960" cellpadding="0" cellspacing="0" align="center">
					<tr>
						<td width="187" valign="top">
							<%-- 							
							<div class="periodBox">
								<div class="period clearfix" id="divPeriodDefault">
									<span class="periodBtn fl"> 
										<a href="#"><img id="imgDefault1d" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1d.gif" alt="당일"></a> 
										<a href="#"><img id="imgDefault1w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1w.gif" alt="1주"></a> 
										<a href="#"><img id="imgDefault2w" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2w.gif" alt="2주"></a> 
										<a href="#"><img id="imgDefault1m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_1m.gif" alt="1개월"></a> 
										<a href="#"><img id="imgDefault2m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_2m.gif" alt="2개월"></a> 
										<a href="#"><img id="imgDefault3m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_3m.gif" alt="3개월"></a> 
										<a href="#"><img id="imgDefault4m" name="imgDefault" src="${adminBean.contextPath}/content/image/b_4mOn.gif" alt="4개월"></a>
									</span> 
									<span class="fl">&nbsp;까지 조회 </span>
								</div>
							</div> <br/> 
							--%>
							<table cellpadding="0" border="0" width="750">
								<tr>
									<td width="750" height="3" bgcolor="#7CBBDE"></td>
								</tr>
								<tr>
									<td width="750" height="2" bgcolor="#FFFFFF">
									<td>
								</tr>
								<tr>
									<td width="750" height="1" bgcolor="#C9C9C9">
									<td>
								</tr>
								<tr>
									<td width="750" id="tdOrderList">
										<table cellpadding='0' cellspacing='0' border='0' width='750'>
											<tr>
												<td colspan='2' width='750' bgcolor='#FFFFFF'> 
													<table id='idMySellListTbl' cellpadding='0' cellspacing='0' border='0' width='750'>
														<thead>
														<tr>
															<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>주문번호</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='80' height='32' align='center' class='infoGray'>주문일자</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='200' height='32' align='center' class='infoGray'>주문내역</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='100' height='32' align='center' class='infoGray'>주문금액/수량</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='125' height='32' align='center' class='infoGray'>주문폰번호</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='125' height='32' align='center' class='infoGray'>주문주소</td>
															<td background='${adminBean.contextPath}/content/image/bg_HalfGray.gif' width='2' height='32'></td>
															<td bgcolor='#F2F2F2' width='75' height='32' align='center' class='infoGray'>수령자</td>
														</tr>
														<tr>
															<td height='1' bgcolor='#E8E8E8' colspan='15'></td>
														</tr>
														</thead>
														<tbody>
														<!-- 여기에 배송할 상품을 표시 -->
														</tbody>
													</table>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='2' bgcolor='#FFFFFF'>
												<td>
											</tr>
											<tr>
												<td colspan='2' width='750' height='1' bgcolor='#C9C9C9'>
												<td>
											</tr>
											<tr>
												<td height='10'></td>
											</tr>
										</table>
									<td>
								</tr>
							</table>
							<div class="graybox"><p class="moveBtn" id="idMoveBtnForSells"> </p></div>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
	</div>
</div>


<%--
<ul class="mypage_tap">
	<li><a href="#" class="deal_info">거래정보</a></li>
	<li><a href="#" class="user_info">개인정보</a></li>
</ul>
<div id="deal_wrap">
	<div class="deal_left">
		<table>
			<tr>
				<th colspan="2">판매 진행 현황</th>
			</tr>
			<tr>
				<td>배송대기 상품</td>
				<td>0 건</td>
			</tr>
			<tr>
				<td>배송진행 상품</td>
				<td>0 건</td>
			</tr>
			<tr>
				<th colspan="2">구매 진행 현황</th>
			</tr>
			<tr>
				<td>입금완료 상품</td>
				<td>0 건</td>
			</tr>
			<tr>
				<td>배송 중 상품</td>
				<td>0 건</td>
			</tr>
			<tr>
				<td>구매확정대기 상품</td>
				<td>0 건</td>
			</tr>
		</table>
	</div>
	<div class="deal_rigth">
		<ul id="sell_wrap">
			<li id="sell_list">
				<div class="deal_header">
					<a href="#" id="idGoodsListOfSelling">판매 거래 리스트</a>
					<div class="deal_SelectWrap">
						<div class="deal_SelectText">
							전체 거래<em>▼</em>
						</div>
						<ul class="deal_boxUI">
							<li>전체 거래 <em>▼</em></li>
							<li>배송대기 상품 <em>▼</em></li>
							<li>배송진행 상품 <em>▼</em></li>
							<li>거래완료 상품 <em>▼</em></li>
						</ul>
					</div>
				</div>
			</li>
			<li id="buy_list">
				<div class="deal_header">
					<a href="#" id="idGoodsListOfbuying">구매 거래 리스트</a>
					<div class="deal_SelectWrap">
						<div class="sell_SelectText">
							전체 거래<em>▼</em>
						</div>
						<ul class="sell_boxUI">
							<li>전체 거래 <em>▼</em></li>
							<li>배송대기 상품 <em>▼</em></li>
							<li>배송진행 상품 <em>▼</em></li>
							<li>거래완료 상품 <em>▼</em></li>
						</ul>
					</div>
				</div>
			</li>
			<li id="sell_board_list">
				<div class="deal_header">
					<a href="#" id="myBoardLists">판매 게시물 리스트</a>
				</div>
			</li>
		</ul>
		<div class="mypage_board">
			<div class="sell_table">
				<table id="sell_table" class="mypage_board_type">
					<thead>
						<tr>
							<th>거래번호</th>
							<th>상품 정보</th>
							<th>거래금액</th>
							<th>배송지 주소</th>
							<th>구매자정보</th>
							<th>거래상태</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
				<div class="graybox">
					<p class="sellMoveBtn"> 
					</p>
					<br> <br>
				</div>
			</div>

			<div class="buy_table">
				<table id="buy_table" class="mypage_board_type">
					<thead>
						<tr>
							<th>거래번호</th>
							<th>상품 정보</th>
							<th>거래금액</th>
							<th>배송지 주소</th>
							<th>판매자정보</th>
							<th>거래상태</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
				<div class="graybox">
					<p class="buyMoveBtn"> 
					</p>
					<br> <br>
				</div>
			</div>

			<div class="board_table">
				<table id="board_table" class="mypage_board_type">
					<thead>
						<tr>
							<th>게시번호</th>
							<th>제목</th>
							<th>가격</th>
							<th>히트수</th>
							<th>등록일</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
				<div class="graybox">
					<p class="boardMoveBtn"> 
					</p>
					<br> <br>
				</div>
			</div>
		</div>
	</div>
</div>

 --%>
<div id="user_wrap">
	<form id="user_form" class="user_form">
		<table>
			<tr>
				<th>이메일</th>
				<td class="user_table_line"><input type="text" name='email' value='${user.email}' class='nochange_input' readonly></td>
			</tr>
			<tr>
				<th>이름</th>
				<td class="user_table_line"><input type="text" name='name' value='${user.name}' class='change_input'></td>
			</tr>
			<tr>
				<th>Phone</th>
				<td class="user_table_line"><input type="text" name='phone' value='${user.phone}' class='change_input'></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td class="user_table_line"><input type="password" id="password_main" name='password' value='${user.password}' class='change_input' required></td>
			</tr>
			<tr>
				<th>비밀번호 재확인</th>
				<td class="user_table_line"><input type="password" id="password_check" value='' class='change_input' required></td>
			</tr>
			<tr>
				<th>주소</th>
				<td class="user_table_line">
					<div class="add_wrap">
						<input type="text" id="sample6_postcode1" value='${address.postNumHeader}'> - <input type="text" id="sample6_postcode2"
							value='${address.postNumTail}'> <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br> <input
							type="text" id="sample6_address" placeholder="주소" name="basicAdd" value='${address.basicAdd}'> <input type="text" id="sample6_address2"
							placeholder="상세주소" name="detailAdd" value='${address.detailAdd}'>
					</div>
				</td>
			</tr>
			<tr>
				<th>카톡아이디</th>
				<td class="user_table_line"><input type="text" name='ktalk' value='${user.ktalkId}' class='change_input'></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td class="user_table_line"><input type="text" name='birthday' value='${user.birthday}' class='change_input'></td>
			</tr>
			<tr>
				<th>자기소개</th>
				<td class="user_table_line"><textarea name='bio' class='change_input'>${user.bio}</textarea></td>
			</tr>
			<tr>
				<th>계좌정보</th>
				<td class="user_table_line">
					<p class="p_in">은행명 :</p> <input type="text" name='bankName' value='${user.bankName}' class='change_input'><br>
					<p class="p_in">계좌번호 :</p> <input type="text" name='bankNum' value='${user.bankNum}' class='change_input'><br>
				</td>
			</tr>
		</table>
		<div class="user_chinge">
			<input type='button' name='cancle' value='Cencel'>
			<button type='submit'>Save</button>
		</div>
	</form>
</div>
