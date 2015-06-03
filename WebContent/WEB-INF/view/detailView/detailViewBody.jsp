<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
<div class="wrap">
	<center>
		<section class="page panel">
			<div class="gallery">
				<div id="photo-viewer"></div>
				<div id="thumbnails">
					<c:forEach var="imagePaths" items="${sessionScope.productDetail.imagePaths}">
						<a href="${imagePaths}" class="thumb active"> <img src="${imagePaths}" width=60 height=60 />
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="description" align="left">
			<ul>
				<li>
					<p class="psTitle"><strong>상품명</strong></p>
					<p class="psDesc"><span>${sessionScope.productDetail.product.name}</span></p>
				</li>
				<li>
					<p class="psTitle"><strong>가격</strong></p>
					</br>
					<p class="psDesc"><span>${sessionScope.productDetail.product.price}</span> 원(개당)</p>
				</li>
				<li>
					<p class="psTitle"><strong>재고</strong></p>
					</br>
					<p class="psDesc">${sessionScope.productDetail.product.stock} 개
				</li>	
				<li>
					<p class="psTitle"><strong>상품설명</strong></p>
					</br>
					<p class="psDesc"><span>${sessionScope.productDetail.product.description}</span></p>
				</li>	
				<c:if test="${sessionScope.productDetail.product.connection > 0}">
					<li>
						<p class="psTitle"><strong>연락방법</strong></p>
						</br>
						<p class="psDesc"><span>${sessionScope.productDetail.product.connectOptionComment}</span></p>
					</li>
				</c:if>	
				<c:if test="${sessionScope.productDetail.product.translation > 0}">
					<li>
						<p class="psTitle"><strong>거래방법</strong></p>
						</br>
						<p class="psDesc"><span>${sessionScope.productDetail.product.translationComment}</span></p>
					</li>
				</c:if>
				<li>
					<a href="" id="buy">Buy now</a> 
				</li>
				</ul>
			</div>
		</section>

		<section class="page">
			<ul class="accordion">
				<li>
					<button class="accordion-control">구매 관련정보</button>
					<div class="accordion-panel">
						<div id="page-wrap">
							<div id="tab_design">
								<nav class="tab_menu clearfix">
									<ul>
										<li><a href="#producer_info"><img src="${adminBean.contextPath}/content/image/detailview_image/faill-icon-24.png" alt="">판매자정보</a></li>
										<li><a href="#ask_reply_info"><img src="${adminBean.contextPath}/content/image/detailview_image/oh-u-icon-24.png" alt="">묻고답하기</a></li>
										<li><a href="#order_reply_info"><img src="${adminBean.contextPath}/content/image/detailview_image/high-icon-24.png" alt="">구매후기</a></li>
									</ul>
								</nav>
								<div class="tab_contents">
									<ul>
										<li id="producer_info">
											
											<img src="${adminBean.contextPath}/content/image/detailview_image/faill-icon-128.png" alt="" />
											<div class="UserDetailTable">
											<table>
												<tr>
													<td width=30%><strong>판매자명</strong></td>
													<td width=70%>${sessionScope.user.name}</td>
												</tr>
												<tr>
													<td width=30%><strong>카카오톡 아이디</strong></td>
													<td width=70%>${sessionScope.user.ktalkId}</td>
												</tr>
												<tr>
													<td width=30%><strong>이메일</strong></td>
													<td width=70%>${sessionScope.user.email}</td>
												</tr>
												<tr>
													<td width=30%><strong>전화번호</strong></td>
													<td width=70%>${sessionScope.user.phone}</td>
												</tr>
											</table>
											</div>
										</li>
										<li id="ask_reply_info">
											<img src="${adminBean.contextPath}/content/image/detailview_image/oh-u-icon-128.png" alt="" width="128" height="128" />
											<h3>묻고 답하기</h3>
											<p>묻고 답하기에 대한 내용을 출력한다.</p>
										</li>
										<li id="order_reply_info">
											<img src="${adminBean.contextPath}/content/image/detailview_image/high-icon-128.png" alt="" width="128" height="128" />
											<h3>구매후기</h3>
											<p>구매후기에 대한 내용 출력한다.</p>
										</li>
									</ul>
								</div>
								<!-- .tab_content-->
							</div>
							<!-- .tab_design-->
						</div>
						<!-- #page-wrap -->
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
					                    <li>
					                        <p>
					                            <a href="/item/7747754"><img src="//img.hellomarket.com/images5/2015/item/s3/05/05/21/0847_7693401_1.jpg" width=86 height=86>
					                            </a><strong><a href="/item/7747754">캠핑용 방석 se...</a></strong><span class="price">8,000원</span>
					                            <span class="time">1970/01/01</span>
					                        </p>
					                    </li>
					                    <li>
					                        <p>
					                            <a href="/item/6893352"><img src="//img.hellomarket.com/images5/2015/item/s3/03/08/23/4147_6893352_1.jpg" width=86 height=86>
					                            </a><strong><a href="/item/6893352">(새것)로우알파인...</a></strong>
					                            <span class="price">20,000원</span>
					                            <span class="time">1970/01/01</span>
					                        </p>
					                    </li>
					                    <li>
					                        <p>
					                            <a href="/item/6892885"><img src="//img.hellomarket.com/images5/2015/item/s3/03/08/23/0817_6892885_1.jpg" width=86 height=86>
					                            </a><strong><a href="/item/6892885">(새것)로우알파인...</a>
					                            </strong><span class="price">70,000원</span>
					                            <span class="time">1970/01/01</span>
					                        </p>
					                    </li>
					                </ul>
					            </div>
					        </div>
					        <p class="moveBtn">
					            <a href="#" id="similar_item_list_prev" class="movepreB">이전 아이템</a>
					            <span id="similar_item_list_page"><strong>1</strong>/10</span>
					            <a href="#" id="similar_item_list_next" class="movenextB">다음 아이템</a>
					        </p>
					    </div>
					</div>
				</li>
			</ul>
		</section>
	</center>
</div>--%>

<div id="wrap">
	<div id="contentArea">
		<!-- CONTENTS -->
		<div id="section">
			<div id="contents">
				<div class="page_navi">
					<div class="location">
						<a href="/">홈</a> <span>&gt;</span> 
						<a href="/category/list.hm?cid=HAD0000">화장품,기타미용제품</a> <span>&gt;</span> 
						<strong>
						<a href="/category/list.hm?cid=HAD0006">이미용제품</a>
						</strong>
					</div>
				</div>
				<div class="viewTopArea">
					<div class="leftArea">
						<a href="#" id="item_top_list_button" class="btn_gray2"><span>목록</span></a>

					</div>
					<div class="rightArea">
						<span class="date">수정일 : 05/11, 등록일 : 05/11</span>
					</div>
				</div>
				<div class="detailView">
					<div class="detailBox">
						<div class="photoArea">
							<div id="item_view_big_photo" class="bigPhoto">
								<a href="#"><img src="//img.hellomarket.com/images5/2015/item/s4/05/11/16/4709_7766636_1.jpg"> </a>
								<div class="text hide" style="display: none;"></div>
							</div>

							<ul id="item_view_mini_photo" class="miniPhoto">
								<c:choose>
									<c:when test="${imagePaths.index == 0}">
								      <li><img src="${imagePath}" rel="${imagePaths.index}" class="on"></li>
								    </c:when> 
									<c:otherwise>
								        <li><img src="${imagePath}" rel="${imagePaths.index}" class=""></li>
								    </c:otherwise>
								</c:choose>
							</ul>
						</div>
						<div class="detailArea">
							<div class="detailInfo">
								<div id="item_view_title_text" class="title">파라핀 네일팩</div>
								<div class="info">
									<dl>
										<dt>가격</dt>
										<dd>
											<span id="item_view_price_text" class="price">12,000원</span>
										</dd>
									</dl>
									<dl>
										<dt>지역</dt>
										<dd></dd>
									</dl>
									<dl>
										<dt>희망연락방법</dt>
										<dd></dd>
									</dl>
									<dl>
										<dt>소셜커뮤니티</dt>
										<dd></dd>
									</dl>
									<dl>
										<dt>특이사항</dt>
										<dd></dd>
									</dl>
								</div>
							</div>
							<div class="userBox">
								<div class="userInfo">
									<div class="userName">
										<p class="name">
											<a href="#" data-midx="358549" data-domain="@1469660" data-nick="초코바닐라♡">초코바닐라♡</a>
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
									휴대폰 번호: 010-4321-6182 <br> 카카오톡 ID: 없음
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
										<h3 class="h3_icon">상세설명</h3>
										<div class="cntView">
											파라핀 네일팩 <br>파라핀10개 들어가고 있구요 <br>집에서도 관리한수 있수 있어서 편안해요 <br>택포 12000원 <br>
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
												<li>
													<p>
														<a href="/item/7747754"><img src="//img.hellomarket.com/images5/2015/item/s3/05/05/21/0847_7693401_1.jpg" width=86 height=86>
														</a><strong><a href="/item/7747754">캠핑용 방석 se...</a></strong><span class="price">8,000원</span> <span class="time">1970/01/01</span>
													</p>
												</li>
												<li>
													<p>
														<a href="/item/6893352"><img src="//img.hellomarket.com/images5/2015/item/s3/03/08/23/4147_6893352_1.jpg" width=86 height=86>
														</a><strong><a href="/item/6893352">(새것)로우알파인...</a></strong> <span class="price">20,000원</span> <span class="time">1970/01/01</span>
													</p>
												</li>
												<li>
													<p>
														<a href="/item/6892885"><img src="//img.hellomarket.com/images5/2015/item/s3/03/08/23/0817_6892885_1.jpg" width=86 height=86>
														</a><strong><a href="/item/6892885">(새것)로우알파인...</a> </strong><span class="price">70,000원</span> <span class="time">1970/01/01</span>
													</p>
												</li>
											</ul>
										</div>
									</div>
									<p class="moveBtn">
										<a href="#" id="similar_item_list_prev" class="movepreB">이전 아이템</a> <span id="similar_item_list_page"><strong>1</strong>/10</span> <a
											href="#" id="similar_item_list_next" class="movenextB">다음 아이템</a>
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