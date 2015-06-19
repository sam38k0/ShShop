<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<ul class="mypage_tap">
    <li><a href="#">거래정보</a></li>
    <li><a href="#">개인정보</a></li>
</ul>
<div id="deal_wrap" >
    <div class="deal_left">
        <table>
            <tr>
                <th colspan="2">판매 진행 현황</th>
            </tr>
            <tr>
                <td>배송대기 상품</td>
                <td>0 건</td>
            </tr>
            <tr>
                <td>배송진행 상품</td>
                <td>0 건</td>
            </tr>
            <tr>
                <th colspan="2">구매 진행 현황</th>
            </tr>
            <tr>
                <td>입금완료 상품</td>
                <td>0 건</td>
            </tr>
            <tr>
                <td>배송 중 상품</td>
                <td>0 건</td>
            </tr>
            <tr>
                <td>구매확정대기 상품</td>
                <td>0 건</td>
            </tr>
        </table>
     </div>
     <ul id="sell_wrap" class="deal_rigth">
         <li id="sell_list" >
            <div class="deal_header">
            	<span>판매 거래 리스트</span> 
            	<div class="deal_SelectWrap">
					<div class="deal_SelectText">전체 거래<em>▼</em></div>
					<ul class="deal_boxUI">
						<li>전체 거래</li>
						<li>배송대기 상품</li>
						<li>배송진행 상품</li>
						<li>거래완료 상품</li>
						<li>악세서리</li>
					</ul>
				</div>
            </div>
        </li>
        <li id="buy_list" >
            <div  class="deal_header">구매 거래 리스트 
                <select name="" id="">
                    <option value="전체 거래 리스트">전체 거래 리스트</option>
                    <option value="배송대기 상품">배송대기 상품</option>
                    <option value="배송진행 상품">배송진행 상품</option>
                    <option value="거래완료 상품">거래완료 상품</option>
                </select>
            </div>
        </li>
        <li id="sell_board_list">
            <p  class="deal_header">판매 게시물 리스트</p>
        </li>
    </ul>
    <div class="mypage_board">
	    <table id="sell_table" class="mypage_board_type">
	        <tr>
	            <th>거래번호</th>
	            <th>상품 정보</th>
	            <th>거래금액</th>
	            <th>배송지 주소</th>
	            <th>구매자정보</th>
	            <th>거래상태</th>
	        </tr>
	        <c:forEach var = 'sellOrder' items='${sellOrderInfoList.orderInfos}'>
	            <tr>
	                <td>${sellOrder.order.orderId}</td>
	                <td><img src="<c:out value="${sellOrder.productImg.imagePath}"/> "><span>${sellOrder.product.productId}</span><br>${sellOrder.product.name}</td>
	                <td>${sellOrder.product.price}</td>
	                <td>${sellOrder.address.basicAdd} ${sellOrder.address.detailAdd}</td>
	                <td>${sellOrder.user.name} <br> ${sellOrder.user.phone}</td>
	                <td>
	                    <span>배송 대기</span><br>
	                    <a href="#">송장 등록</a>
	                    <div class="parcel_service">
	                        택배사 
	                        <select name="" id="">
	                            <option value="">대한통운</option>
	                            <option value="">한진택배</option>
	                        </select>
	                        <input type="text" value="송장 번호">
	                        <input type="button" value="송장 등록">
	                    </div>
	                </td>
	            </tr>
	        </c:forEach>
	    </table>
	
	    <table id="buy_table" class="mypage_board_type">
	        <tr>
	            <th>거래번호</th>
	            <th>상품 정보</th>
	            <th>거래금액</th>
	            <th>배송지 주소</th>
	            <th>구매자정보</th>
	            <th>거래상태</th>
	        </tr>
	        <c:forEach var = 'buyOrder' items='${buyOrderInfoList.orderInfos}'>
	        <tr>
	            <td>${buyOrder.order.orderId}</td>
	            <td><span>${buyOrder.product.productId}</span><br>${buyOrder.product.name}</td>
	            <td>${buyOrder.product.price}</td>
	            <td>${buyOrder.address.basicAdd} ${buyOrder.address.detailAdd}</td>
	            <td>${buyOrder.user.name}<br>${buyOrder.user.phone}</td>
	            <td>
	                <span>배송 대기</span><br>
	            </td>
	        </tr>
	        </c:forEach>
	    </table>
	
	    <table id="board_table" class="mypage_board_type">
	        <tr>
	            <th></th>
	        </tr>
	        <tr>
	            <td></td>
	        </tr>
	    </table>
    </div>
</div>

<div id="user_wrap">
	<form id="user_form" class="user_form">
		<table>
			<tr>
				<th>이메일</th>
				<td class="user_table_line"><input type="text" name='email' value='${user.email}' class='nochange_input' readonly></td>
			</tr>
			<tr>
				<th>이름</th>
				<td class="user_table_line"><input type="text" name='name' value='${user.name}' class='change_input'></td>
			</tr>
			<tr>
				<th>Phone</th>
				<td class="user_table_line"><input type="text" name='phone' value='${user.phone}' class='change_input'></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td class="user_table_line"><input type="password" id="password_main" name='password' value='${user.password}' class='change_input' required></td>
			</tr>
			<tr>
				<th>비밀번호 재확인</th>
				<td class="user_table_line"><input type="password" id="password_check" value='' class='change_input' required></td>
			</tr>
			<tr>
				<th>주소</th>
				<td class="user_table_line">
					<div class="add_wrap">
						<input type="text" id="sample6_postcode1"> -
						<input type="text" id="sample6_postcode2">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample6_address" placeholder="주소" name="basicAdd" value='${address.basicAdd}'>
						<input type="text" id="sample6_address2" placeholder="상세주소" name="detailAdd" value='${address.detailAdd}'>
					</div>
				</td>
			</tr>
			<tr>
				<th>카톡아이디</th>
				<td class="user_table_line"><input type="text" name='ktalk' value='${user.ktalkId}' class='change_input'></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td class="user_table_line"><input type="text" name='birthday' value='${user.birthday}' class='change_input'></td>
			</tr>
			<tr>
				<th>자기소개</th>
				<td class="user_table_line"><textarea name='bio' class='change_input'>${user.bio}</textarea></td>
			</tr>
			<tr>
				<th>계좌정보</th>
				<td class="user_table_line">
					<p>은행명 : </p><input type="text" name='bankName' value='${user.bankName}' class='change_input'><br>
					<p>계좌번호 : </p><input type="text" name='bankNum' value='${user.bankNum}' class='change_input'><br>
					</td>
				</tr>
			</table>
			<input type='button' name='cancle' value='취소'><button type='submit'>수정</button>
		</form>
	</div>
</div>