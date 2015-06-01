<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div id="banner">
	<ul class="show_banner">
         <li><a href="#"><img src="${adminBean.contextPath}/content/image/ben1.jpg" alt="베너1"></a></li>
         <li><a href="#"><img src="${adminBean.contextPath}/content/image/ben2.jpg" alt="베너2"></a></li>
         <li><a href="#"><img src="${adminBean.contextPath}/content/image/ben3.jpg" alt="베너3"></a></li>
    </ul>
	<div class="control">
		<a href="#" id="prevBtn"><img src="${adminBean.contextPath}/content/image/left_btn.png" alt=""></a> 
		<a href="#" id="nextBtn"><img src="${adminBean.contextPath}/content/image/right_btn.png" alt=""></a>
	</div>
</div>
<div id="main_listarea">
	<div class="main_content">
		<p>[HOT] 인기상품</p>
		<ul class="hot_item_area">
			<c:forEach  var="productC" items="${productsC}">
				<li class="hot_item"><img src="http://placehold.it/110x110" alt=""><span>${productC.name}</span><br><em>${productC.price}</em></li>
			</c:forEach>
		</ul>
	</div>
	<div class="main_content">
		<p>[NEW] 신규상품</p>
		<ul class="new_item_area">
			<c:forEach  var="productD" items="${productsD}">
				<li class="new_item"><img src="http://placehold.it/110x110" alt=""><span>${productD.name}</span><br><em>${productD.price}</em></li>
			</c:forEach>
		</ul>
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