<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div class="wrap">
<center>
<section class="page panel">
	<div class="gallery">
		<div id="photo-viewer"></div>
		<div id="thumbnails">
			<a href="${adminBean.contextPath}/content/image/detailview_image/photo-1.jpg" class="thumb active" title="Elderberry Marshmallow">
				<img src="${adminBean.contextPath}/content/image/detailview_image/thumb-1.jpg" alt="Elderberry Marshmallow" /> 
			</a>
			<a href="${adminBean.contextPath}/content/image/photo-2.jpg" class="thumb" title="Rose Marshmallow">
				<img src="${adminBean.contextPath}/content/image/detailview_image/thumb-2.jpg" alt="Rose Marshmallow" /> 
			</a> 
			<a href="${adminBean.contextPath}/content/image/photo-3.jpg" class="thumb" title="Crysanthemum Marshmallow">
				<img src="${adminBean.contextPath}/content/image/detailview_image/thumb-3.jpg" alt="Crysanthemum Marshmallow" /> 
			</a>
		</div>
	</div>
	<div class="description">
		<p class="psTitle">
			<strong>상품제목</strong>
		</p>
		<p></p>
		<p class="psDesc">
			상품설명 <strong>강조</strong>, <strong>강조</strong>, 머시기머시기 <strong>힘들다</strong>슈밤
		</p>
		<p></p>
		<p class="psDesc">
			상품설명 <strong>강조</strong>, <strong>강조</strong>, 머시기머시기 <strong>힘들다</strong>슈밤
		</p>
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
								<li><a href="#product_info"><img src="${adminBean.contextPath}/content/image/detailview_image/yo-icon-24.png" alt="">상품정보</a></li>
								<li><a href="#producer_info"><img src="${adminBean.contextPath}/content/image/detailview_image/faill-icon-24.png" alt="">판매자정보</a></li>
								<li><a href="#ask_reply_info"><img src="${adminBean.contextPath}/content/image/detailview_image/oh-u-icon-24.png" alt="">묻고 답하기</a></li>
								<li><a href="#pick_item_info"><img src="${adminBean.contextPath}/content/image/detailview_image/nose-pick-icon-24.png" alt="">찜하기</a></li>
								<li><a href="#order_info"><img src="${adminBean.contextPath}/content/image/detailview_image/nom-nom-icon-24.png" alt="">구매하기</a></li>
								<li><a href="#order_reply_info"><img src="${adminBean.contextPath}/content/detailview_image/image/high-icon-24.png" alt="">구매후기</a></li>
							</ul>
						</nav>
						<div class="tab_contents">
							<ul>
								<li id="product_info"><img src="${adminBean.contextPath}/content/image/detailview_image/yo-icon-128.png" alt="" width="128" height="128" />
									<h3>상품정보</h3>
									<p>상품 정보에 대한 내용을 출력한다.</p></li>

								<li id="producer_info"><img src="${adminBean.contextPath}/content/image/detailview_image/faill-icon-128.png" alt="" width="128" height="128" />
									<h3>판매자정보</h3>
									<p>판매자 정보를 출력한다.</p></li>
								<li id="ask_reply_info"><img src="${adminBean.contextPath}/content/image/detailview_image/oh-u-icon-128.png" alt="" width="128" height="128" />
									<h3>묻고 답하기</h3>
									<p>묻고 답하기에 대한 내용을 출력한다.</p></li>
								<li id="pick_item_info"><img src="${adminBean.contextPath}/content/image/detailview_image/nose-pick-icon-128.png" alt="" width="128" height="128" />
									<h3>찜하기</h3>
									<p>찜하기에 대한 내용을 출력한다.</p></li>
								<li id="order_info"><img src="${adminBean.contextPath}/content/image/detailview_image/nom-nom-icon-128.png" alt="" width="128" height="128" />
									<h3>구매</h3>
									<p>구매에 대한 내용 출력한다.</p></li>
								<li id="order_reply_info"><img src="${adminBean.contextPath}/content/image/detailview_image/high-icon-128.png" alt="" width="128" height="128" />
									<h3>구매후기</h3>
									<p>구매후기에 대한 내용 출력한다.</p></li>
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
			<button class="accordion-control">상품 상세보기</button>
			<div class="accordion-panel">
				<p>상세보기 영역</p>
			</div>
		</li>
		<li>
			<button class="accordion-control">유사상품 보기</button>
			<div class="accordion-panel">
				<p>유사 아이템 보기 영역</p>
			</div>
		</li>
	</ul>
</section>
</center>
</div>