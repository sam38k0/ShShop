<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<div id="wrap">
	<div id="contentArea">
		<!-- CONTENTS -->
		<div id="section">
			<div id="contents">
				<div class="viewTopArea">
					<div class="leftArea">
						<a href="#" id="item_top_list_button" class="btn_gray2"><span>목록</span></a>
					</div>
					<div class="rightArea">
						<span class="date">수정일 : ${sessionScope.productDetail.product.dateUpdated}, 등록일 : ${sessionScope.productDetail.product.dateCreated} </span>
					</div>
				</div>
				<div class="detailView">
					<div class="detailBox">
						<div class="photoArea">
							<div id="item_view_big_photo" class="bigPhoto">
								<a href="#"><img src="<c:out value="${sessionScope.productDetail.imagePaths[1]}"/> "> </a>
								<div class="text hide" style="display: none;"></div>
							</div>
							<ul id="item_view_mini_photo" class="miniPhoto">
								<c:forEach var="imagePath" varStatus="imagePaths" items="${sessionScope.productDetail.imagePaths}">
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
										<c:when test="${sessionScope.productDetail.product.name == '' || sessionScope.productDetail.product.name == null }">
										       상품이름없음
										</c:when>
										<c:otherwise>
										    ${sessionScope.productDetail.product.name}
										</c:otherwise>
									</c:choose>
								</div>

								<div class="info">
									<dl>
										<dt>가격</dt>
										<dd>
											<span id="item_view_price_text" class="price">${sessionScope.productDetail.product.price} 원</span>
										</dd>
									</dl>
									<dl>
										<dt>지역</dt>
										<dd></dd>
									</dl>
									<dl>
										<dt>거래방법</dt>
										<c:choose>
											<c:when test="${sessionScope.productDetail.product.translationComment == '' || sessionScope.productDetail.product.translationComment == null }">
											      <dd>등록하지 않음</dd>
											</c:when>
											<c:otherwise>
											    <dd>${sessionScope.productDetail.product.translationComment}</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<dl>
										<dt>희망연락방법</dt>
										<c:choose>
											<c:when
												test="${sessionScope.productDetail.product.connectOptionComment == '' || sessionScope.productDetail.product.connectOptionComment == null }">
												<dd>등록하지 않음</dd>
											</c:when>
											<c:otherwise>
												<dd>${sessionScope.productDetail.product.connectOptionComment}</dd>
											</c:otherwise>
										</c:choose>
									</dl>
								</div>
							</div>
							<div class="userBox">
								<div class="userInfo">
									<div class="userName">
										<p class="name">
											<c:choose>
												<c:when test="${sessionScope.productDetail.productOwner.name == '' || sessionScope.productDetail.productOwner.name == null }">
										       		<a href="#" data-midx="358549" data-domain="@1469660" data-nick="이름없음">이름없음</a>
												</c:when>
												<c:otherwise>
										    		<a href="#" data-midx="358549" data-domain="@1469660" data-nick="${sessionScope.productDetail.productOwner.name}">${sessionScope.productDetail.productOwner.name}</a>
												</c:otherwise>
											</c:choose>
										</p>
										<ul class="userLevel">
										</ul>
									</div>
								</div>
								<div class="userList">
									<div class="userPhoto snsNo">
										<p>
											<a href="/@1469660"> <img id="member_image" src="//image.hellomarket.com/common/photo_user_w32.gif">
											</a>
										</p>
										<ul id="member_sns" class="userSns">
										</ul>
									</div>
									<ul class="userArticle">
										<li>판매자 다른 아이템 <a href="/@1469660" id="item_view_ticnt_button">22</a>건
										</li>
										<li>판매자 과거 거래한 아이템 <a href="/item/pastList.hm?midx=358549" id="item_view_dicnt_button">3</a>건
										</li>
										<li>판매자가 남긴 모든 글 <a href="/search?q=초코바닐라♡&amp;sm=358549&amp;sd=cmm" id="item_view_tdcnt_button">0</a>건
										</li>
									</ul>
								</div>
							</div>
							<!-- //userBox -->

							<div id="item_view_phone_layer" class="openBox hide" style="display: block;">
								<div class="phone">
									<c:choose>
									    <c:when test="${sessionScope.productDetail.productOwner.phone == '' || sessionScope.productDetail.productOwner.phone == null }">
									       	휴대폰 번호 : 없음
									    </c:when> 
									    <c:otherwise>
									               휴대폰 번호 :  ${sessionScope.productDetail.productOwner.phone}
									    </c:otherwise>
									</c:choose> 
									<br>
									<c:choose>
									    <c:when test="${sessionScope.productDetail.productOwner.ktalkId == '' || sessionScope.productDetail.productOwner.ktalkId == null }">
									       	카카오톡 ID : 없음
									    </c:when> 
									    <c:otherwise>
									      	  카카오톡 ID : ${sessionScope.productDetail.productOwner.ktalkId}
									    </c:otherwise>
									</c:choose>
									<br>
									<c:choose>
									    <c:when test="${sessionScope.productDetail.productOwner.email == '' || sessionScope.productDetail.productOwner.email == null }">
									       	이메일 : 없음
									    </c:when> 
									    <c:otherwise>
									      	  이메일 :  ${sessionScope.productDetail.productOwner.email}
									    </c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="functionBtn">
								<ul>
									<li><a href="#" data-flag="n" id="wish_button" data-id="7766636" class="zzim">구매하기</a></li>
									<li><a href="#" data-flag="n" id="recommend_button" data-id="7766636" class="basket">장바구니</a></li>
									<li><a href="#" data-flag="n" id="recommend_button" data-id="7766636" class="like">추천하기</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- //detailCnt -->
				<div class="accordion">
					<ul>
						<li>
							<button class="accordion-control">제품 상세정보</button>
							<div class="accordion-panel">
								<div class="detailCnt">
									<div class="detailCntL">
										<h3 class="h3_icon">재고</h3>
										<div class="cntView">
											${sessionScope.productDetail.product.stock}
										</div>
										<h3 class="h3_icon">상세설명</h3>
										<div class="cntView">
											${sessionScope.productDetail.product.description}
										</div>
										<h3 class="h3_icon">댓글달기</h3>
										<div id="comment_list" class="cmtView clearfix">
											<div id="comment_view_all" class="cmtAll" style="display: none;">
												<span class="arr"></span><a href="#">이전 댓글 보기</a> <span class="hide">#total_count#개 중 <b>3</b>개
												</span>
											</div>

											<div class="cmtWrite">
												<textarea placeholder="댓글을 입력하세요" class="cmtTextarea" rel="auto_grow" style="width: 580px; height: 50px;"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div> <!-- .accordion-panel -->
						</li>
						<li>
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