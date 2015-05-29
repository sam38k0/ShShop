<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="wrap">
	<center>
		<section class="page panel">
			<div class="gallery">
				<div id="photo-viewer"></div>
				<div id="thumbnails">
					<c:forEach var="imagePaths" items="${sessionScope.productDetail.imagePaths}">
						<a href="${imagePaths}" class="thumb active" width=400 height=300> <img src="${imagePaths}" width=60 height=60 />
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
</div>