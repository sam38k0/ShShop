<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" import="com.shshop.service.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="adminBean" class="com.shshop.system.AdminBean" scope="session" />


<div id="searchContentArea">
	<div id="section">
		<div id="contents">
		
			<!-- 결과 내 재검색 -->
			<div class="srcinResult_title"></div>
			<div class="srcinResultBox">
				<div class="srcinResultBox_min">
					<div class="priceArea">
						<p>가격</p>
						<div class="priceInput">
							<input id="price_from" type="text"> 원 ~ <input id="price_to" type="text"> 원
						</div>
					</div>

					<div class="srcinResult_input">
						<button type="submit" title="검색" id="btn_visible_search">검색</button>
					</div>
				</div>
			</div>
			<!-- //결과 내 재검색 -->

			<!-- 정렬 조건 -->
			<div class="itemListTop">
				<h3>
					‘뷰티’ 결과 : <span id="itemListCount"></span>
				</h3>
				<div class="sortBar">
					<ul id="list_sort" class="sortLeft">
						<li rel="st1" class="on">최신순</li>
						<li rel="st2">인기순</li>
						<li rel="st3">고가순</li>
						<li rel="st4">저가순</li>
					</ul>
				</div>
			</div>
			<!-- //정렬 조건 -->

			<!-- 결과뷰 -->
			<div class="itemListTable">
				<table class="itemList">
					<colgroup>
						<col width="120">
						<col width="*">
						<col width="130">
						<col width="100">
						<col width="120">
						<col width="120">
						<col width="120">
					</colgroup>
					<thead align="center">
						<tr>
							<th colspan="2">제목</th>
							<th>가격</th>
							<th>안전결제</th>
							<th>판매자</th>
							<th>판매자등급</th>
							<th class="end">등록일</th>
						</tr>
					</thead>
					<tbody>
					<%--
						<tr>
							<td>
								<div id="7939615" class="outline">
									<a href="/item/7939615?cid=HAD0000&amp;cnm=뷰티"> 
										<img src="//img.hellomarket.com/images5/2015/item/s3/05/25/14/5102_7939615_1.jpg" width="90" height="90">
									</a>
								</div>
							</td>
							<td class="itemCnt">
								<div class="itemInfo">
									<p class="title">
										<a href="/item/7939615?cid=HAD0000&amp;cnm=뷰티">에센스</a>
									</p>
									<p class="location">군포시</p>
								</div>
							</td>
							<td class="price">8,000원</td>
							<td class="safeOrder">안전결제</td>
							<td class="user">아이디</td>
							<td class="userLevel">1등급</td>
							<td class="time">42초전</td>
						</tr>
						 --%>
					</tbody>
				</table>
			</div>
			<!-- //결과뷰 -->
			
		</div>
	</div>
</div>