<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div class="mypage_tap">
	<ul>
		<li><a href="#">판매</a></li>
		<li><a href="#">구매</a></li>
		<li><a href="#">개인정보</a></li>
	</ul>
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