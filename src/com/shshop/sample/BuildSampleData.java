package com.shshop.sample;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.domain.Board;
import com.shshop.domain.Category;
import com.shshop.domain.Post;
import com.shshop.domain.PostProc;
import com.shshop.domain.Product;
import com.shshop.domain.ProductProc;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.mapper.BoardMapper;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.PostMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

public class BuildSampleData {
	static SqlSession sqlSession = null;
	static ProductMapper productMapper = null;
	static UserMapper userMapper = null;
	static CategoryMapper categoryMapper = null;
	static PostMapper postMapper = null;
	static BoardMapper boardMapper = null;

	public static void main(String[] args) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		userMapper = sqlSession.getMapper(UserMapper.class);
		categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		productMapper = sqlSession.getMapper(ProductMapper.class);
		postMapper = sqlSession.getMapper(PostMapper.class);
		boardMapper = sqlSession.getMapper(BoardMapper.class);

		insertUser();
		insertCategory();

		// 여성의류
		int categoryId = 1;
		inputSampleProducts(categoryId, "(여)티셔츠");
		inputSampleProducts(categoryId, "(여)니트");
		inputSampleProducts(categoryId, "(여)조끼");
		inputSampleProducts(categoryId, "(여)남방");
		inputSampleProducts(categoryId, "(여)바지");
		inputSampleProducts(categoryId, "(여)코트");
		inputSampleProducts(categoryId, "(여)패딩");
		inputSampleProducts(categoryId, "(여)정장");
		inputSampleProducts(categoryId, "(여)원피스");
		inputSampleProducts(categoryId, "(여)트레이닝복");

		// 남성의류
		categoryId += 1;
		inputSampleProducts(categoryId, "(남)티셔츠");
		inputSampleProducts(categoryId, "(남)니트");
		inputSampleProducts(categoryId, "(남)조끼");
		inputSampleProducts(categoryId, "(남)남방");
		inputSampleProducts(categoryId, "(남)바지");
		inputSampleProducts(categoryId, "(남)코트");
		inputSampleProducts(categoryId, "(남)정장");
		inputSampleProducts(categoryId, "(남)트레이닝복");
		inputSampleProducts(categoryId, "(남)등산복");

		// 화장품
		categoryId += 1;
		inputSampleProducts(categoryId, "여성화장품");
		inputSampleProducts(categoryId, "메이크업");
		inputSampleProducts(categoryId, "바디케어");
		inputSampleProducts(categoryId, "남성화장품");
		inputSampleProducts(categoryId, "향수");
		inputSampleProducts(categoryId, "아로마");

		// 잡화
		categoryId += 1;
		inputSampleProducts(categoryId, "티켓");
		inputSampleProducts(categoryId, "쿠폰");
		inputSampleProducts(categoryId, "시즌권");
		inputSampleProducts(categoryId, "골동품");
		inputSampleProducts(categoryId, "희귀품");
		inputSampleProducts(categoryId, "소품");
		inputSampleProducts(categoryId, "수제품");

		// 출산/아동
		categoryId += 1;
		inputSampleProducts(categoryId, "출산용품");
		inputSampleProducts(categoryId, "신생아의류");
		inputSampleProducts(categoryId, "유아의류");
		inputSampleProducts(categoryId, "유아생활용품");
		inputSampleProducts(categoryId, "유아도서");
		inputSampleProducts(categoryId, "완구");
		inputSampleProducts(categoryId, "교육용완구");
		inputSampleProducts(categoryId, "아동의류");
		inputSampleProducts(categoryId, "여자아동의류");

		// 가구
		categoryId += 1;
		inputSampleProducts(categoryId, "책상");
		inputSampleProducts(categoryId, "책장");
		inputSampleProducts(categoryId, "의자");
		inputSampleProducts(categoryId, "침대의자");
		inputSampleProducts(categoryId, "침대");
		inputSampleProducts(categoryId, "완구");
		inputSampleProducts(categoryId, "카페트");
		inputSampleProducts(categoryId, "수납책상");

		// 게임
		categoryId += 1;
		inputSampleProducts(categoryId, "닌텐도DS");
		inputSampleProducts(categoryId, "PSP");
		inputSampleProducts(categoryId, "PS2");
		inputSampleProducts(categoryId, "PS3");
		inputSampleProducts(categoryId, "PS4");
		inputSampleProducts(categoryId, "Wii");
		inputSampleProducts(categoryId, "Xbox");
		inputSampleProducts(categoryId, " 퍼즐게임");

		// 가전
		categoryId += 1;
		inputSampleProducts(categoryId, "홈씨어터");
		inputSampleProducts(categoryId, "DVD플레이어");
		inputSampleProducts(categoryId, "오디오");
		inputSampleProducts(categoryId, "MP3");
		inputSampleProducts(categoryId, "PMP");
		inputSampleProducts(categoryId, "이어폰");
		inputSampleProducts(categoryId, "스피커");
		inputSampleProducts(categoryId, "마이크");

		// 모바일
		categoryId += 1;
		inputSampleProducts(categoryId, "SKT");
		inputSampleProducts(categoryId, "KT");
		inputSampleProducts(categoryId, "LGU+");
		inputSampleProducts(categoryId, "휴대폰액세서리");
		inputSampleProducts(categoryId, "스마트패드");
		inputSampleProducts(categoryId, "스마트폰액정");
		inputSampleProducts(categoryId, "외출시폰");
		inputSampleProducts(categoryId, "휴대폰주변기기");

		// 레저
		categoryId += 1;
		inputSampleProducts(categoryId, "등산용품");
		inputSampleProducts(categoryId, "캠핑용품");
		inputSampleProducts(categoryId, "헬스요가용품");
		inputSampleProducts(categoryId, "스키");
		inputSampleProducts(categoryId, "보드");
		inputSampleProducts(categoryId, "자전거");
		inputSampleProducts(categoryId, "골프");
		inputSampleProducts(categoryId, "축구");
		inputSampleProducts(categoryId, "야구");
		inputSampleProducts(categoryId, "농구");
		inputSampleProducts(categoryId, "낚시");
		inputSampleProducts(categoryId, "수상스포츠");

		// 도서
		categoryId += 1;
		inputSampleProducts(categoryId, "대학교재");
		inputSampleProducts(categoryId, "외국어");
		inputSampleProducts(categoryId, "학습소설");
		inputSampleProducts(categoryId, "문학경영");
		inputSampleProducts(categoryId, "경제");
		inputSampleProducts(categoryId, "인문");
		inputSampleProducts(categoryId, "사회컴퓨터");
		inputSampleProducts(categoryId, "과학문화");
		inputSampleProducts(categoryId, "만화책");
		inputSampleProducts(categoryId, "잡지");
		
		// 묻고 답하기 코멘트 추가
		inputSampleComment();

		sqlSession.commit();
		
		System.out.println("Insertion Completed");
	}

	private static void inputSampleComment() {
		boardMapper.insertBoard(new Board(Constant.askAndReplyBoard));
		Board board = boardMapper.getBoardByName(Constant.askAndReplyBoard);
		Product product = productMapper.getProductById(1);
		User user = userMapper.getUserById(product.getUserId());
 
		List<Post> posts = new ArrayList<>();
		posts.add( new Post("comment1", board.getBoardId(), null, 0) );
		posts.add( new Post("comment11", board.getBoardId(), 1, 0) ); 
		posts.add( new Post("comment111", board.getBoardId(), 2, 0) ); 
		posts.add( new Post("comment2", board.getBoardId(), null, 0) ); 
		posts.add( new Post("comment21", board.getBoardId(), 4, 0) ); 
		
		for(Post post : posts) { 
			postMapper.insertPostByProc(new PostProc(post,user,product));
		}
	}

	private static void insertCategory() {
		categoryMapper.insertRootCategory(new Category("여성의류", "여성의류Desc", "여성의류Link"));
		categoryMapper.insertRootCategory(new Category("남성의류", "남성의류Desc", "남성의류Link"));
		categoryMapper.insertRootCategory(new Category("화장품", "화장품Desc", "화장품Link"));
		categoryMapper.insertRootCategory(new Category("잡화", "잡화Desc", "잡화Link"));
		categoryMapper.insertRootCategory(new Category("출산/아동", "출산/아동Desc", "출산/아동Link"));
		categoryMapper.insertRootCategory(new Category("가구", "가구Desc", "가구Link"));
		categoryMapper.insertRootCategory(new Category("게임", "게임Desc", "게임Link"));
		categoryMapper.insertRootCategory(new Category("가전", "가전Desc", "가전Link"));
		categoryMapper.insertRootCategory(new Category("모바일", "모바일Desc", "모바일Link"));
		categoryMapper.insertRootCategory(new Category("레저", "레저Desc", "레저Link"));
		categoryMapper.insertRootCategory(new Category("도서", "도서Desc", "도서Link"));
	}

	private static void insertUser() {
		userMapper.insertUser(new User("name1@gmail.com", "1111", "name1", "111-111-1111", "ktalk1", "bio1", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name2@gmail.com", "2222", "name2", "222-222-2222", "ktalk2", "bio2", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name3@gmail.com", "3333", "name3", "333-333-3333", "ktalk3", "bio3", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name4@gmail.com", "4444", "name4", "444-444-4444", "ktalk4", "bio4", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name5@gmail.com", "5555", "name5", "555-555-5555", "ktalk5", "bio5", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name6@gmail.com", "6666", "name6", "666-666-6666", "ktalk6", "bio6", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name7@gmail.com", "7777", "name7", "777-777-7777", "ktalk7", "bio7", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name8@gmail.com", "8888", "name8", "888-888-8888", "ktalk8", "bio8", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name9@gmail.com", "9999", "name9", "999-999-9999", "ktalk9", "bio9", Format.getSqlDate(Format.randDate())));
	}

	private static void inputSampleProducts(int categoryId, String productNameHeader) {
		StringBuilder imageStrBuilder = new StringBuilder();
		String tagNameHeader = productNameHeader + "tag";
		String descriptionHeader = productNameHeader + "desc";

		int count = Format.randInt(100, 200);
		for (int i = 0; i < count; i++) {
			imageStrBuilder.setLength(0);
			imageStrBuilder.append("/content/image/product_image/sample1.jpg,");
			imageStrBuilder.append("/content/image/product_image/sample2.jpg,");
			imageStrBuilder.append("/content/image/product_image/sample3.jpg,");
			imageStrBuilder.append("/content/image/product_image/sample4.jpg");
			productMapper.insertProductProc(new ProductProc(Format.randInt(1, 9), categoryId, productNameHeader + i, 100 * (i + 1), Format.randInt(1,
					1000), i%2 + 1 , 204, tagNameHeader + i, descriptionHeader + i, Format.randInt(1, 10000), true, true, false, imageStrBuilder
					.toString()));
		}
	}
}
