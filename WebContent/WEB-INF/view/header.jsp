<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="java.util.*, com.shshop.command.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />

<div class="headwrap">
	<!-- 헤더 시작 -->
	<div id="header">
		<!-- 전체 카테고리 시작 -->
		<div id="category">
			<span>카테고리 선택</span>
			<ul class="allcategory">
				<li><a href="#" class="choice">의류</a>
					<ul class="allcategory">
						<li><a href="#">상의</a></li>
						<li><a href="#">하의</a></li>
						<li><a href="#">외투</a></li>
					</ul></li>
				<li><a href="#">장난감</a></li>
				<li><a href="#">가전</a></li>
				<li><a href="#">아동용품</a></li>
				<li><a href="#">기타</a></li>
			</ul>
		</div>
		<!-- 전체 카테고리 종료 -->
		<!-- 검색바 시작 -->
		<div id="search">
			<select>
				<option>전체</option>
				<option>의류</option>
				<option>장난감</option>
				<option>가전</option>
				<option>악세서리</option>
			</select> 
			<input type="text"> 
			<input type="submit" value="검색">
		</div>
		<!-- 검색바 종료 -->
		<!-- 상품등록버튼 시작 -->
		<div id="link">
			<form id="insertProductForm" name="insertProductForm" method="post" action="insertProductView">
				<input type="submit" value="판매등록">
			</form>
			<form id="insertHopeProductForm" name="insertHopeProductForm" method="post" action="insertHopeProductView">
				<input type="submit" value="구매등록">
			</form>
		</div>
		<!-- 상품등록버튼 종료 -->

		<!-- 로그인 전 서브 메뉴 시작 -->
		<ul class="gnb_before_login">
			<li><a href="viewMain">홈</a></li>
			<li>|</li>
			<li><div id="loginDiv">
					<a><img src="${adminBean.contextPath}/content/image/login.png" title="로그인" width="30" height="30" alt="Share icon" /> </a>
				</div></li>
			<li>|</li>
			<li><div id="registerUserDiv">
					<a><img src="${adminBean.contextPath}/content/image/addUser.png" title="회원가입" width="30" height="30" alt="Share icon" /> </a>
				</div></li>
			<!-- <li><a href="#" class="join_btn">회원가입</a></li>  -->
		</ul>

		<ul class="gnb_after_login">
			<li><a href="viewMain">홈</a></li>
			<li>|</li>
			<li><div id="share_logout">
					<a href="viewMain"><img src="${adminBean.contextPath}/content/image/logout.png" title="로그아웃" width="30" height="30" alt="Share icon" /> </a>
				</div></li>
			<li>|</li>
			<li><a href="#">마이페이지</a></li>
			<li>|</li>
			<li><a href="#">장바구니</a></li>
		</ul>

		<!-- 로그인 후 서브 메뉴 종료 -->

	</div>
	<!-- 헤더 종료 -->
</div>

<!--- 로그인--->
<div class="m_login">
	<div id="login-options">
		<form id="loginForm" name="loginForm">
			<div class="two-thirds column" id="main">
				<fieldset>
					<legend>Login</legend>
					<label for="email">Email:</label> 
					<input type="email" id="email" name="email" placeholder="you@yourdomain.com" required /> 
					<label for="pwd">Password:</label>
					<input type="password" id="pwd" name="pwd" value="" required /> <br /> 
					<input type="checkbox" id="showPwd"> <label for="showPwd">show password</label> 
					<input id="cancel" type="button" value="Back" /> 
					<input type='button' id='loginBtn' value="Login" /> 
					<div id="message"></div>
				</fieldset>
			</div>
		</form>

	</div>
	<!-- share-options -->
</div>

<div id="m_join">
	<div id="register_options">
		<form id="registerForm" name="register">
			<div class="one-third column">
				<img src="${adminBean.contextPath}/content/image/registerUser.png" alt="logo" id="logo" />
				<h2 class="welcome">Become a Member</h2>
				<p class="intro">ShShop 에 오신것을 환영합니다. ShShop 에서 다양한 중고 아이템들을 만나보세요. 다양한 중고 상품과 실시간으로 크고 작은 이벤트, 해택 및 안전한 거래를 하실 수 있습니다.</p>
			</div>
			<div class="one-third column">
				<h2>Settings</h2>
				<br />
				<div class="name">
					<label for="name">Name:</label> 
					<input type="text" placeholder="Enter your name" name="name" id="name-reg">
				</div>
				<div class="email">
					<label for="email" class="required">Email:</label> 
					<input type="email" placeholder="you@example.com" name="email" id="email-reg" required>
				</div>
				<div class="password">
					<label for="password" class="required">Password: (min 8 characters)</label> 
					<input type="password" name="password" id="password-reg" required>
				</div>
				<div class="password">
					<label for="conf-password" class="required">Confirm password:</label> 
					<input type="password" name="conf-password" id="conf-password-reg" required>
				</div>
				<div class="ktalk">
					<label for="ktalk">Kakao Talk ID:</label> 
					<input type="text" placeholder="Enter your Ktalk ID" name="ktalk" id="ktalk-reg">
				</div>
				<div class="phone">
					<label for="phone">Phone Number:</label> 
					<input type="number" placeholder="Enter your Phone Num" name="phone" id="phone-reg">
				</div>
			</div>
			<div class="one-third column">
				<h2>Profile</h2>
				<br />
				<div class="birthday">
					<label for="birthday">Birthday:</label> 
					<input type="date" name="birthday" id="birthday-reg" placeholder="yyyy-mm-dd">
				</div>
				<div class="bio">
					<label for="bio">Short Bio (max 140 characters):</label>
					<textarea name="bio" id="bio-reg" rows="5" cols="30"></textarea>
				</div>
				<div class="register">
					<input type="submit" value="Register"><br /> 
					<input id="cancelReg" type="button" value="Back" />
				</div>
				<div id="message-reg"></div>
			</div>
		</form>
	</div>
</div>

<!--- 비밀번호찾기 --->
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
