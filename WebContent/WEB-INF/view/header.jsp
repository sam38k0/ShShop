<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="java.util.*, com.shshop.command.*"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<div class="headwrap">	
	<!-- 헤더 시작 -->
	<div id="header">
		<div id="header_logo"><a href="viewMain"><img src="${adminBean.contextPath}/content/image/default/header_logo.png"></a></div>
		<!-- 검색바 시작 -->
		<div id="search">
			<form action="searchView" method="get">
				<div class="divSelectWrap">
					<div class="divSelectText">전체</div>
					<ul class="selectboxUI">
						<li>전체</li>
						<li>의류</li>
						<li>장난감</li>
						<li>가전</li>
						<li>악세서리</li>
					</ul>
				</div>
				<input type="text" id="keywords" name="keywords" >
				<button type="submit" value="Submit">검색</button>
			</form>
		</div>
		<!-- 검색바 종료 -->
		<!-- 상품등록버튼 시작 -->
		<div id="link">
			<form id="insertProductForm" name="insertProductForm" method="post" action="insertProductView">
				<input type="submit" value="판매등록">
			</form>
			<!-- <form id="insertHopeProductForm" name="insertHopeProductForm" method="post" action="insertHopeProductView">
				<input type="submit" value="구매등록">
			</form> -->
		</div>
		<!-- 상품등록버튼 종료 -->
		
		<!-- 로그인 전 서브 메뉴 시작 -->
		<ul class="gnb_before_login">
			<li><a href="viewMain">HOME</a></li>
			<li>ㆍ</li>
			<li id="loginDiv">
				<a href="#">LOGIN</a>
			</li>
			<li>ㆍ</li>
			<li id="registerUserDiv">
				<a href="#">JOIN</a>
			</li>
			<!-- <li><a href="#" class="join_btn">회원가입</a></li>  -->
		</ul>
		<ul class="gnb_after_login">
			<li><a href="viewMain">HOME</a></li>
			<li>ㆍ</li>
			<li id="share_logout">
				<a href="#">LOGOUT</a>
			</li>
			<li>ㆍ</li>
			<li><a href="mypage">MYPAGE</a></li>
			<li>ㆍ</li>
			<li><a href="showShoppingCartView" id="virtualOrderHeader">BASKET( 
				<c:choose>
					<c:when test="${virtualOrderCount == null || virtualOrderCount == '' }">
						0
					</c:when>
					<c:otherwise>
						${virtualOrderCount}
					</c:otherwise>
				</c:choose> 
				)</a>
			</li>
		</ul>
		<!-- 로그인 후 서브 메뉴 종료 -->
	</div>
	<!-- 전체 카테고리 시작 -->
	<div class="category_wrap">
		<div id="category">
			<ul class="allcategory">
				<%
					CategoryControlService categoryControlService = new CategoryControlService();
		            out.print(categoryControlService.buildHtml(false,true));
	            %>
			</ul>
		</div>
	</div>
	<!-- 전체 카테고리 종료 -->
		
	<!-- 헤더 종료 -->
</div>
 
<!--- 로그인--->
<div class="blind">
	<div id="login-options">
		<form id="loginForm" name="loginForm">
			<div class="login_set column" id="main">
				<div class="login_title"><h1>Login</h1><div class="m_logo"><img src="${adminBean.contextPath}/content/image/default/header_logo.png"></div></div>
				<div class="login_list">
					<label for="email">Email:</label> 
					<input type="email" id="email" name="email" placeholder="you@yourdomain.com" required />
				</div>
				<div class="login_list">
					<label for="pwd">Password:</label>
					<input type="password" id="pwd" name="pwd" value="" required />
					<input type="checkbox" id="showPwd"> <label for="showPwd" class="login_no_margin">show password</label> 
				</div>
				<div class="loginForm_btn">
				<input id="cancel" type="button" value="Back" /><input type='button' id='loginBtn' value="Login" /></div>
				<div id="message"></div>
			</div>
		</form>

	</div>
	<!-- share-options -->
</div>

<!--- 회원가입 --->
<div id="m_join">
	<div id="register_options">
		<form id="registerForm" name="register">
			<%-- <div class="one-third column">
				<img src="${adminBean.contextPath}/content/image/registerUser.png" alt="logo" id="logo" />
				<h2 class="welcome">Become a Member</h2>
				<p class="intro">ShShop 에 오신것을 환영합니다. ShShop 에서 다양한 중고 아이템들을 만나보세요. 다양한 중고 상품과 실시간으로 크고 작은 이벤트, 해택 및 안전한 거래를 하실 수 있습니다.</p>
			</div> --%>
			<div class="join_set">
				<div class="join_title"><h1>Sign up</h1><div class="m_logo"><img src="${adminBean.contextPath}/content/image/default/header_logo.png"></div></div>
				<div class="name join_list">
					<label for="name">Name:</label> 
					<input type="text" placeholder="Enter your name" name="name" id="name-reg">
				</div>
				<div class="email join_list">
					<label for="email" class="required">Email:</label> 
					<input type="email" placeholder="you@example.com" name="email" id="email-reg" required>
				</div>
				<div class="password join_list">
					<label for="password" class="required">Password:<span>(min 8 characters)</span></label> 
					<input type="password" name="password" id="password-reg" required>
				</div>
				<div class="password join_list">
					<label for="conf-password" class="required">Confirm password:</label> 
					<input type="password" name="conf-password" id="conf-password-reg" required>
				</div>
				<div class="ktalk join_list">
					<label for="ktalk">Kakao Talk ID:</label> 
					<input type="text" placeholder="Enter your Ktalk ID" name="ktalk" id="ktalk-reg">
				</div>
				<div class="phone join_list">
					<label for="phone">Phone Number:</label> 
					<input type="number" placeholder="Enter your Phone Num" name="phone" id="phone-reg">
				</div>
				<div class="birthday join_list">
					<label for="birthday">Birthday:</label> 
					<input type="date" name="birthday" id="birthday-reg" placeholder="yyyy-mm-dd">
				</div>
				<div class="bio join_list">
					<label for="bio">Short Bio:<span>(max 140 characters)</span></label>
					<textarea name="bio" id="bio-reg" rows="5" cols="30"></textarea>
				</div>
				<div class="register join_btn">
					<input id="cancelReg" type="button" value="Back" /><input id="joinBtn" type="submit" value="Register">
				</div>
				<div id="message-reg"></div>
			</div>
		</form>
	</div>
</div>

<!--- 비밀번호찾기 
<div id="m_password">
	<div class="closeBtn">
		<a href="#"><img src="${adminBean.contextPath}/content/image/login_close.png" alt="닫기"></a>
	</div>
	<div class="m_logo">비밀번호찾기</div>
	<div class="pass m_info">
		<span>E-mail</span> <input type="text">
	</div>
	<button type="submit" class="m_submit">임시 비밀번호 발송</button>
</div>
--->