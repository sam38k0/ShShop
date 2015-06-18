<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session= "true" import ="com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:useBean id ="adminBean" class ="com.shshop.system.AdminBean" scope ="session"/>

<div class="wrap">
	<center>
		<form id="insertProductForm" name="insertProduct" method="post" enctype="multipart/form-data" action="insertProduct">
			<table class="productTable">
				<tr>
					<td><b>카테고리선택</b></td>
					<td align=left>

						<div id="category">
							<span>Category</span>
							<ul class="allcategory" id="CategoryItems">
								<%
                            		CategoryControlService categoryControlService = new CategoryControlService();
                            		out.print(categoryControlService.buildHtml(false,false));
                            	%>
							</ul>
						</div> 
						<input type="text" name="miniCategory" id="categoryResult" placeholder="여성의류 > 부츠/레인부츠 > 가죽롱부츠 > 로우힐" required>
					</td>
				</tr>
				<tr>
					<td><b>상품명</b></td>
					<td align=left><input type=text name=productname></td>
				</tr>
				<tr>
					<td><b>거래방법</b></td>
					<td align=left>
						<select id="transactionType" name="transactionType" required>
							<option value="">거래 방법을 선택하세요</option>
							<option value="1">안전결제</option>
							<option value="2">택배</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><b>연락방법</b></td>
					<td>
					    <fieldset>
					    	<div class="connectionList">
						    	<label><input type="checkbox" value="all" id="all"> All </label>
						    	<ul>
						    		<li><input type="checkbox" id="connection1" value="1" name="connectionOpt1"> 직접통화</li>
						    		<li><input type="checkbox" id="connection2" value="2" name="connectionOpt2"> SMS</li>
						    		<li><input type="checkbox" id="connection3" value="4" name="connectionOpt3"> 카톡</li>
						    		<li><input type="checkbox" id="connection4" value="8" name="connectionOpt4"> 이메일</li>
						    		<li><input type="checkbox" id="connection5" value="16" name="connectionOpt5"> 쪽지</li>
						    		<li><input type="checkbox" id="connection6" value="32" name="connectionOpt6"> 채팅</li>
						    		<li><input type="checkbox" id="connection7" value="64" name="connectionOpt7"> 댓글</li>
						    	</ul>
					    	</div>
			            </fieldset>
					</td>
				</tr>
				<tr>
					<td><b>판매가격</b></td>
					<td align=left><input type=number name=price required></td>
				</tr>
				<tr>
					<td><b>재고량</b></td>
					<td align=left><input type=number name=stock required></td>
				</tr>
				<tr>
					<td><b>이미지</b></td>
					<td align=left>
						<div class="alert alert-info">
 
							<input type="file" accept=".gif, .jpg, .png" name="file" style="visibility: hidden;" id="fileId1" /> </br>
							<div class="input-append">
								<input type="text" id="subfile1" class="input-xlarge"> 
								<a class="btn" onclick="$('#fileId1').click();">Browse</a>
							</div>

							<input type="file" accept=".gif, .jpg, .png" name="file" style="visibility: hidden;" id="fileId2" /> </br>
							<div class="input-append">
								<input type="text" id="subfile2" class="input-xlarge"> 
								<a class="btn" onclick="$('#fileId2').click();">Browse</a>
							</div>

							<input type="file" accept=".gif, .jpg, .png" name="file" style="visibility: hidden;" id="fileId3" /> </br>
							<div class="input-append">
								<input type="text" id="subfile3" class="input-xlarge"> 
								<a class="btn" onclick="$('#fileId3').click();">Browse</a>
							</div>

							<input type="file" accept=".gif, .jpg, .png" name="file" style="visibility: hidden;" id="fileId4" /> </br>
							<div class="input-append">
								<input type="text" id="subfile4" class="input-xlarge"> 
								<a class="btn" onclick="$('#fileId4').click();">Browse</a>
							</div>

							<input type="file" accept=".gif, .jpg, .png" name="file" style="visibility: hidden;" id="fileId5" /> </br>
							<div class="input-append">
								<input type="text" id="subfile5" class="input-xlarge"> 
								<a class="btn" onclick="$('#fileId5').click();">Browse</a>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><b>상품 설명</b></td>
					<td align=left><textarea rows=5 name=description></textarea></td>
				</tr>
				<tr>
					<td><b>태그입력</b></td>
					<td align=left><input type="text" name="tag" data-role="tagsinput"></td>
				</tr>
				<tr>
					<td><b>사용약관</b></td>
					<td align=left>
						<p>
							● 판매서비스 이용료 : 구매자가 카드 결제 시 3%(원), 현금결제 시 1.5% (0원)</br> 
							● 최종정산 예정금액 : 약 0원 (이용료는 판매대금 정산 시 차감됩니다.)
						</p>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center">
					<input type="button" value="Back" onClick="history.back()"> 
					<input type="submit" value="Register"></td>
				</tr>
			</table>
		</form>
	</center>
</div>
