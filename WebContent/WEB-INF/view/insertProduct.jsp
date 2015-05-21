<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page session= "true" import ="java.util.*, com.shshop.command.*, com.shshop.service.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	<title>insertProduct</title>
	<link rel="stylesheet" href="../content/css/command.css" type="text/css" />
	<link rel="stylesheet" href="../content/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="../content/css/product.css" type="text/css" />
    <script src="../content/js/jquery_1.9.js"></script>
    <script src="../content/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(

            function () {
                $('#fileId1').change(function () {
                    $('#subfile1').val($(this).val());
                });
                $('#fileId2').change(function () {
                    $('#subfile2').val($(this).val());
                });
                $('#fileId3').change(function () {
                    $('#subfile3').val($(this).val());
                });
                $('#fileId4').change(function () {
                    $('#subfile4').val($(this).val());
                });
                $('#fileId5').change(function () {
                    $('#subfile5').val($(this).val());
                });
            });
    </script>
    <title>InsertProduct</title>
</head> 
<body>
    <div class="wrap">
        <center>
            <hr width=1000>
            <h3>상품 등록</h3>
            <hr width=1000> 
            <form id="insertProductForm" name="insertProductForm"  method="post" enctype="multipart/form-data" action="insertProduct">
                <table class="flat-table">
                    <tr>
                        <td><b>카테고리선택</b>
                        </td>
                        <td align=left>
                        	
                            <div id="category">
                            	<span>Category</span>
                                <ul class="allcategory">
                               	 <%
                            		CategoryControlService categoryControlService = new CategoryControlService();
                            		out.print(categoryControlService.buildHtml());
                            	 %>
                                </ul>
                            </div>
                             <input type="text" name="miniCategory" size=50 value="여성의류 > 부츠/레인부츠 > 가죽롱부츠 > 로우힐">
                        </td>
                    </tr>
                    <tr>
                        <td><b>상품명</b>
                        </td>
                        <td align=left>
                            <input type=text name=pmodel>
                        </td>
                    </tr>
                    <tr>
                        <td><b>거래방법</b>
                        </td>
                        <td align=left>
                            <select id="transactionType" name="transactionType">
                                <option value="choose">거래 방법을 선택하세요</option>
                                <option value="key 1">안전결제</option>
                                <option value="key 2">택배</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><b>판매가격</b>
                        </td>
                        <td align=left>
                            <input type=text name=price>
                        </td>
                    </tr>
                    <tr>
                        <td><b>재고량</b>
                        </td>
                        <td align=left>
                            <input type=text name=pcompany>
                        </td>
                    </tr>
                    <tr>
                        <td><b>이미지</b>
                        </td>
                        <td align=left>
                            <div class="alert alert-info">
                                <input type="file" name="file" style="visibility:hidden;" id="fileId1" />
                                <label>최대 5개까지 등록하실 수 있습니다.</label>
                                <div class="input-append">
                                    <input type="text" id="subfile1" class="input-xlarge">
                                    <a class="btn" onclick="$('#fileId1').click();">Browse</a>
                                </div>

                                <input type="file" name="file" style="visibility:hidden;" id="fileId2" />
                                </br>
                                <div class="input-append">
                                    <input type="text" id="subfile2" class="input-xlarge">
                                    <a class="btn" onclick="$('#fileId2').click();">Browse</a>
                                </div>

                                <input type="file" name="file" style="visibility:hidden;" id="fileId3" />
                                </br>
                                <div class="input-append">
                                    <input type="text" id="subfile3" class="input-xlarge">
                                    <a class="btn" onclick="$('#fileId3').click();">Browse</a>
                                </div>
                                
                                <input type="file" name="file" style="visibility:hidden;" id="fileId4" />
                                </br>
                                <div class="input-append">
                                    <input type="text" id="subfile4" class="input-xlarge">
                                    <a class="btn" onclick="$('#fileId4').click();">Browse</a>
                                </div>

                                <input type="file" name="file" style="visibility:hidden;" id="fileId5" />
                                </br>
                                <div class="input-append">
                                    <input type="text" id="subfile5" class="input-xlarge">
                                    <a class="btn" onclick="$('#fileId5').click();">Browse</a>
                                </div>
                            </div>
                        </td>
                    </tr>
					<%--
                    <tr>
                        <td><b>옵션 선택</b>
                        </td>
                        <td align=left>
                            <select id="productTypeSelect" name="productTypeSelect">
                                <option value="choose">옵션</option>
                                <option value="key 1">product 1</option>
                                <option value="key 2">product 2</option>
                            </select>
                        </td>
                    </tr>
                     --%>
                    <tr>
                        <td><b>상품 설명</b>
                        </td>
                        <td align=left>
                            <textarea rows=5 cols=50 name=pcontents></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td><b>태그입력</b>
                        </td>
                        <td align=left>
                            <input type=text name=pmodel>
                        </td>
                    </tr>
                    <tr>
                        <td><b>사용약관</b>
                        </td>
                        <td align=left>
                            <p>● 판매서비스 이용료 : 구매자가 카드 결제 시 3%(원), 현금결제 시 1.5% (0원)</br>
                               ● 최종정산 예정금액 : 약 0원 (이용료는 판매대금 정산 시 차감됩니다.)</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=2 align="center">
                            <input type=button value="Back">
                            <input type="submit" value="Register">
                        </td>
                    </tr>
                </table>
            </form>
        </center>
    </div>
</body>
</html>

 