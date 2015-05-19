<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page session= "true" import ="java.util.*, com.shshop.command.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>search</title>
        <link rel="stylesheet" href="../content/css/command.css">
    </head>
    <body>
        <div class="wrap">
            <div class="header_area">
                <!--헤더 인크루트 영역-->
            </div>
            
            <!---- search 영역 ---->
            <div id="search_area">
                <!---- 서브 카테고리 영역 ---->  
                <div id="sub_catagory">
                    <ul class="sub_ctg">
                        <li>▶</li>
                        <li>카테고리1</li>
                        <li>카테고리2</li>
                    </ul>
                    <div class="sub_key"><span>관련 인기 키워드 : </span>
                        <ul>
                            <li>키워드1, </li>
                            <li>키워드2</li>
                        </ul>
                    </div>
                </div>
                <!---- 게시판 타입 영역 ---->
                <div id="search_type">
                    <ul id="search_round">
                        <li><a href="#">최신순</a></li>
                        <li><a href="#">댓글순</a></li>
                        <li><a href="#">고가순</a></li>
                        <li><a href="#">저가순</a></li>
                    </ul>
                    <ul id="search_choice">
                        <li><input type="checkbox">사진있는것만</li>
                        <li><input type="checkbox">인증회원만</li>
                        <li><input type="checkbox">안전결제만</li>
                        <li><button type="submit">검색</button></li>
                    </ul>
                    <ul id="search_type_choice">
                        <li><a href="#"><img src="image/list_type_1.png" alt="게시판형"></a></li>
                        <li><a href="#"><img src="image/list_type_2.png" alt="게시판+이미지"></a></li>
                        <li><a href="#"><img src="image/list_type_3.png" alt="이미지"></a></li>
                    </ul>
                </div>
                <!---- 게시판 테이블 내용 ---->
                <div id="search_list">
                    <!---- 게시판형 테이블 ---->
                    <div id="search_text">
                        <div class="text_list text_head">
                            <ul>
                                <li>상품번호</li>
                                <li>상품정보</li>
                                <li>가격</li>
                                <li>안전결제</li>
                                <li>판매자</li>
                                <li>등록일</li>
                            </ul>
                        </div>
                        <div class="text_list text_body">
                            <ul>
                                <li>123123</li>
                                <li class="text_detail"><img src="http://placehold.it/100x100" alt="상품이미지">
                                    <span>상품제목</span>
                                <li>2000 <span>택포</span></li>
                                <li class="payment"><img src="http://placehold.it/100x100" alt="안전결제여부"></li>
                                <li class="certify">아이디<span>인증유무</span></li>
                                <li>1시간전</li>
                            </ul>
                        </div>
                    </div>
                    <!---- 게시판 + 이미지형 테이블 ---->
                    <div id="search_img_text">
                        <div class="img_text_grid">
                            <img src="http://placehold.it/200x200" alt="">
                            <p>상품제목</p>
                            <em>상품 가격</em><br>
                            <span>등록 경과 시간(일자)</span>
                        </div>
                        <div class="img_text_grid">
                            <img src="http://placehold.it/200x200" alt="">
                            <p>상품제목</p>
                            <em>상품 가격</em><br>
                            <span>등록 경과 시간(일자)</span>
                        </div>
                        <div class="img_text_grid">
                            <img src="http://placehold.it/200x200" alt="">
                            <p>상품제목</p>
                            <em>상품 가격</em><br>
                            <span>등록 경과 시간(일자)</span>
                        </div>
                        <div class="img_text_grid">
                            <img src="http://placehold.it/200x200" alt="">
                            <p>상품제목</p>
                            <em>상품 가격</em><br>
                            <span>등록 경과 시간(일자)</span>
                        </div>
                    </div>
                    <!---- 이미지형 테이블 ---->
                    <div id="search_img">
                        <div class="img_grid">
                            <a href="#"><img src="http://placehold.it/150x150" alt="">
                                <span>미리보기</span>
                            </a>
                        </div>
                        
                    </div>
                </div>
            </div>
            
            <div class="footer_area">
                <!--푸터 인크루트 영역-->
            </div>
        </div>
    </body>
</html>