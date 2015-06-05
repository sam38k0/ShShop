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
					"<span id="searchKeyWords"><%-- [DataNeed!!] --%></span>" 결과 : <span id="itemListCount"><%-- [DataNeed!!] --%></span>(개)
				</h3>
				<div class="sortBar">
					<ul id="list_sort" class="sortLeft">
						<li sort="1" id="sortByDate" class="on">최신순</li>
						<li sort="2" id="sortByHit">인기순</li>
						<li sort="3" id="sortByHighPrice">고가순</li>
						<li sort="4" id="sortByLowPrice">저가순</li>
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
							<th>히트수</th>
							<th class="end">등록일</th>
						</tr>
					</thead>
					<tbody>
					 <%-- 아래 형식을 따름
						<tr>
							<td>
								<div id="..." class="outline">
									<a href="#"> 
										<img src="/xxxx.jpg" width="90" height="90">
									</a>
								</div>
							</td>
							<td class="itemCnt">
								<div class="itemInfo">
									<p class="title">
										<a href="#">에센스</a>
									</p>
									<p class="location">군포시</p>
								</div>
							</td>
							<td class="price">8,000원</td>
							<td class="safeOrder">안전결제</td>
							<td class="userName">아이디</td>
							<td class="hitCount">1000</td>
							<td class="time">42초전</td>
						</tr>
						 --%>
					</tbody>
				</table>
			</div>
			<!-- //결과뷰 -->
			
			<!-- 페이징 -->
			<div class="paginationFooter">
			    <div class="page">
			    	<div id="pagingSearchResults">
			    		<%-- 아래 형식을 따름
	                    <a href="#" class="arrow" data-page="10">&lt;</a>
	                    <span>1</span>
	                    <a href="#" data-page="2">2</a>
	                    <a href="#" data-page="3">3</a>
	                    <a href="#" data-page="4">4</a> 
	                    <a href="#" data-page="5">5</a> 
	                    <a href="#" data-page="6">6</a> 
	                    <a href="#" data-page="7">7</a> 
	                    <a href="#" data-page="8">8</a> 
	                    <a href="#" data-page="9">9</a> 
	                    <a href="#" data-page="10">10</a> 
	                    <a href="#" class="arrow" data-page="21">&gt;</a> 
	                     --%>
			    	</div>
                </div>
            </div>
			<!-- 페이징 -->
		</div>
	</div>
</div>