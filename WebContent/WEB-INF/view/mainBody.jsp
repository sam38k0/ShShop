<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div id="banner">
	<img src="${adminBean.contextPath}/content/image/ben.jpg" alt="베너1">
	<div class="control">
		<a href="#" id="prevBtn"><img src="${adminBean.contextPath}/content/image/left_btn.png" alt=""></a> 
		<a href="#" id="nextBtn"><img src="${adminBean.contextPath}/content/image/right_btn.png" alt=""></a>
	</div>
</div>
<div id="main_listarea">
	<div class="main_content">
		<p>[HOT] 인기상품</p>
		<div class="item_area">
			<ul>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
			</ul>
			<div class="control">
				<a href="#" id="prevBtn"><img src="${adminBean.contextPath}/content/image/left_btn.png" alt=""></a> 
				<a href="#" id="nextBtn"><img src="${adminBean.contextPath}/content/image/right_btn.png" alt=""></a>
			</div>
		</div>
	</div>
	<div class="main_content">
		<p>[NEW] 신규상품</p>
		<div class="item_area">
			<ul>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
				<li><img src="http://placehold.it/110x110" alt=""></li>
			</ul>
			<div class="control">
				<a href="#" id="prevBtn"><img src="${adminBean.contextPath}/content/image/left_btn.png" alt=""></a> 
				<a href="#" id="nextBtn"><img src="${adminBean.contextPath}/content/image/right_btn.png" alt=""></a>
			</div>
		</div>
	</div>
</div>
<div id="main_rightbox">
	<div id="on_off_btn">
		<img src="${adminBean.contextPath}/content/image/right_btn.png" alt="">
	</div>
	<p>최근 본 상품 리스트</p>
	<ul>
		<li><img src="http://placehold.it/100x100" alt=""><span>제목</span></li>
		<li><img src="http://placehold.it/100x100" alt=""><span>제목</span></li>
		<li><img src="http://placehold.it/100x100" alt=""><span>제목</span></li>
	</ul>
</div>