<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<div id="wrap">
	<div id="contentArea">
		<!-- CONTENTS -->
		<div id="section">
			<div id="contents">
				<div class="viewTopArea">
					<div class="rightArea">
						<span class="date">수정일 : ${productDetail.product.dateUpdated}, 등록일 : ${productDetail.product.dateCreated} </span>
					</div>
				</div>
				<div class="detailView">
					<div class="detailBox">
						<div class="photoArea">
							<div id="item_view_big_photo" class="bigPhoto">
								<a href="#"><img src="<c:out value="${productDetail.imagePaths[0]}"/> "> </a>
								<div class="text hide" style="display: none;"></div>
							</div>
							<ul id="item_view_mini_photo" class="miniPhoto">
								<c:forEach var="imagePath" varStatus="imagePaths" items="${productDetail.imagePaths}">
									<c:choose>
										<c:when test="${imagePaths.index == 0}">
											<li><img src="${imagePath}" rel="${imagePaths.index}" class="on"></li>
										</c:when>
										<c:otherwise>
											<li><img src="${imagePath}" rel="${imagePaths.index}" class=""></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
						<div class="detailArea">
							<div class="detailInfo">
								<div id="item_view_title_text" class="title">
									<c:choose>
										<c:when test="${productDetail.product.name == '' || productDetail.product.name == null }">
										       상품이름없음
										</c:when>
										<c:otherwise>
										    ${productDetail.product.name}
										</c:otherwise>
									</c:choose>
								</div>

								<div class="info">
									<dl>
										<dt>가격</dt>
										<dd>
											<span id="item_view_price_text" class="price">${productDetail.product.price} 원</span>
										</dd>
									</dl>
									<dl>
										<dt>재고량</dt>
										<dd>
											<span id="item_view_price_text">${productDetail.product.stock} 개</span>
										</dd>
									</dl>
									<dl>
										<dt>지역</dt>
										<c:choose>
										<c:when test="${productDetail.productOwnerBasicAddress == '' || productDetail.productOwnerBasicAddress == null }">
										       <dd>등록지역 없음</dd>
										</c:when>
										<c:otherwise>
										   <dd>${productDetail.productOwnerBasicAddress}</dd>
										</c:otherwise>
									</c:choose>
										
									</dl>
									<dl>
										<dt>거래방법</dt>
										<c:choose>
											<c:when test="${productDetail.product.translationComment == '' || productDetail.product.translationComment == null }">
											      <dd>등록하지 않음</dd>
											</c:when>
											<c:otherwise>
											    <dd>${productDetail.product.translationComment}</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<dl>
										<dt>희망연락방법</dt>
										<c:choose>
											<c:when
												test="${productDetail.product.connectOptionComment == '' || productDetail.product.connectOptionComment == null }">
												<dd>등록하지 않음</dd>
											</c:when>
											<c:otherwise>
												<dd>${productDetail.product.connectOptionComment}</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<dl>
										<dt>주문수량</dt>
										<dd>
											<input id="ord_goods_cnt" type="number" class="ordNum" value="1">
										</dd>
									</dl>
								</div>
							</div>
							<div class="userBox">
								<div class="userInfo">
									<div class="userName">
										<p class="name">
											<c:choose>
												<c:when test="${productDetail.productOwner.name == '' || productDetail.productOwner.name == null }">
										       		<a href="#" data-midx="358549" data-domain="@1469660" data-nick="이름없음">이름없음</a>
												</c:when>
												<c:otherwise>
										    		<a href="#" data-midx="358549" data-domain="@1469660" data-nick="${productDetail.productOwner.name}">${productDetail.productOwner.name}</a>
												</c:otherwise>
											</c:choose>
										</p>
									</div>
								</div>
								<div class="userList">
									<div class="userPhoto snsNo"> 
										<a href="#"> <img id="member_image" src="${adminBean.contextPath}/content/image/photo_user_w32.gif"></a> 
									</div>
									<ul class="userArticle">
										<li>판매자 다른 아이템 <a href="#" id="item_view_ticnt_button">${productDetail.productOwnerItemCount}</a>건
										</li>
										<li>
										<c:choose>
											<c:when test="${productDetail.productOwner.phone == '' || productDetail.productOwner.phone == null }">
									       	휴대폰 번호 : 없음
									    	</c:when>
											<c:otherwise>
									               휴대폰 번호 :  ${productDetail.productOwner.phone}
									    	</c:otherwise>
										</c:choose>
										</li>
										<li>
										<c:choose>
											<c:when test="${productDetail.productOwner.ktalkId == '' || productDetail.productOwner.ktalkId == null }">
									       	카카오톡 ID : 없음
									    	</c:when>
											<c:otherwise>
									      	  카카오톡 ID : ${productDetail.productOwner.ktalkId}
									    	</c:otherwise>
										</c:choose>
										</li>
										<li>
										<c:choose>
											<c:when test="${productDetail.productOwner.email == '' || productDetail.productOwner.email == null }">
									       	이메일 : 없음
									    	</c:when>
												<c:otherwise>
									      	이메일 :  ${productDetail.productOwner.email}
									    	</c:otherwise>
											</c:choose>
										</li>
									</ul>
								</div>
							</div>
							<!-- //userBox --> 
							<div class="functionBtn">
								<ul>
									<li><a id="virtualOrder" href="#"><img title="카트에 넣기" alt="카트에 넣기" id="cart_btn" src="${adminBean.contextPath}/content/image/b_addtoCart.gif" style="cursor:pointer;margin: 10px;width:100px;height:60px;"></a></li>
									<li><a id="directOrder" href="showDirectOrderView?productId=<c:out value="${productDetail.product.productId}"/>"><img title="바로 구매하기" alt="바로 구매하기" src="${adminBean.contextPath}/content/image/b_buy.gif" style="cursor:pointer;margin: 10px;width:100px;height:60px;"></a></li>
								</ul> 
							</div>
						</div>
					</div>
				</div>
				<!-- //detailCnt -->
				<div class="accordion">
					<ul>
						<li class="accordion_list">
							<button class="accordion-control">제품 상세정보</button>
							<div class="accordion-panel">
								<div class="detailCnt">
									<div class="detailCntL">
										<h3 class="h3_icon">재고</h3>
										<div class="cntView">
											${productDetail.product.stock} 개
										</div>
										<h3 class="h3_icon">상세설명</h3>
										<div class="cntView">
											${productDetail.product.description}
										</div>
										<h3 class="h3_icon">댓글달기</h3>
										<div id="comment_list" class="cmtView clearfix">
											 ${productDetail.postResults}
											 <div class="cmtWrite">
												<textarea placeholder="댓글을 입력하세요" class="cmtTextarea" style="width: 580px; height: 50px;"></textarea>
											</div>
										</div>
									</div>
									<div class="detailCntR">
										<div class="tipBoxWrap">
											<div class="tipT"></div>
											<div class="tipPrivate">안전한 구매를 위한 간단한 팁</div>
											<div class="tipBox">
												<div class="tipCnt">
													<p class="textgreen">가격이 너무 싸거나, 판매를 서두르는 경우에는 주의 바랍니다.</p>
													<dl>
														<dt>직접 거래를 하는 경우</dt>
														<dd>
															<ul>
																<li>① 판매자의 과거 거래 아이템/회원, 남긴 글/댓글 확인</li>
																<li>② 판매자 신용도 및 거래 상태 제공</li>
																<li>③ 판매자 이웃 및 과거 거래한 회원을 통한 판매자 관련 문의</li>
																<li>④ 송금시 ShShop에 인증된 판매자 계좌번호 사용</li>
																<li>⑤ 판매자가 남긴 삭제한 댓글 제공</li>
															</ul>
														</dd>
													</dl>
													<dl>
														<dt>ShShop 안전결제서비스를 이용하는 경우</dt>
														<dd>
															<ul>
																<li>① 결제처리 업무(카드결제 및 현금영수증 등) 대행 </li>
																<li>② 공지사항, 행정조치사항, 사용허가 등 정보제공을 위한 문자메시지 전송</li>
																<li>③ 송금시 ShShop에 인증된 판매자 계좌번호 사용</li>
																<li>④ 판매자와의 대화내용 동봉 발송</li>
																<li>⑤ ShShop 내에서 운영하는 안전결제서비스만 이용</li>
															</ul>
														</dd>
													</dl>
												</div>
											</div>
											<div class="tipB"></div>
										</div>
									</div>
								</div>
							</div> <!-- .accordion-panel -->
						</li>
						<li class="accordion_list">
							<button class="accordion-control">유사상품 보기</button>
							<div class="accordion-panel">
								<div class="graybox">
									<h4>해당 아이템과 유사한 아이템</h4>
									<div class="horizontal_box">
										<div class="itembox">
											<ul id="similar_item_list" class="similar" style="display: block;">
											 <%-- 여기에 Similar Item 추가 --%>
											</ul>
										</div>
									</div>
									<p class="moveBtn">
 										<%-- 여기에 Button Control 추가 --%>
									</p>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- //content -->

		</div>
		<!-- //section -->
		<!-- //CONTENTS -->

	</div>
	<!-- //contentArea -->
</div>

<script src="js/jquery-1.11.0.min.js"></script>
<script src="js/test.js"></script>
