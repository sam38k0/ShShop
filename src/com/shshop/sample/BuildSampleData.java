package com.shshop.sample;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.domain.Address;
import com.shshop.domain.AddressProc;
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
		inputSampleProducts("여성 티셔츠","(여)티셔츠");
		inputSampleProducts("여성 니트류","(여)니트");
		inputSampleProducts("여성 조끼류", "(여)조끼");
		inputSampleProducts("원피스", "(여)원피스");
		inputSampleProducts("기타 여성복", "(여)바지");
		inputSampleProducts("기타 여성복", "(여)코트");
		inputSampleProducts("기타 여성복", "(여)패딩");

		// 남성의류
		inputSampleProducts("남성 티셔츠", "(남)티셔츠");
		inputSampleProducts("남성 니트류", "(남)니트");
		inputSampleProducts("남성 조끼류", "(남)조끼");
		inputSampleProducts("남성 자켓", "(남)자켓");
		inputSampleProducts("남성 속옷", "(남)팬티");
		inputSampleProducts("기타 남성복", "(남)코트");
		inputSampleProducts("기타 남성복", "(남)정장");
		inputSampleProducts("기타 남성복", "(남)트레이닝복");
		inputSampleProducts("기타 남성복", "(남)등산복");

		// 화장품
		inputSampleProducts("메이크업", "BB크림");
		inputSampleProducts("향수", "샤넬");
		inputSampleProducts("바디", "바디케어");
		inputSampleProducts("헤어", "우루스");
		inputSampleProducts("헤어", "비달사순");
		inputSampleProducts("아로마", "아로마 손 청결제");

		// 잡화 
		inputSampleProducts("신발", "NIKE");
		inputSampleProducts("지갑", "장지갑");
		inputSampleProducts("모자", "흑간지모자");
		inputSampleProducts("벨트", "성인용벨트");
		inputSampleProducts("안경", "선글라스"); 

		// 출산/아동
 
		inputSampleProducts("유아의류", "면귀저기");
		inputSampleProducts("신생아의류", "종이귀저기");
		inputSampleProducts("유아도서", "MAXIM");
		inputSampleProducts("아동의류", "뽀로로티셔츠");
		inputSampleProducts("완구", "뽀로로완구");

		// 가구
		inputSampleProducts("책상", "고급책상");
		inputSampleProducts("의자", "듀오벡");
		inputSampleProducts("침대", "물침대");
		inputSampleProducts("쇼파", "레이지보이");
		inputSampleProducts("싱크대", "싱크대용품"); 

		// 게임
		inputSampleProducts("닌텐도", "닌텐도DS");
		inputSampleProducts("PSP", "PS3");
		inputSampleProducts("Wii", "Wii");
		inputSampleProducts("XBox", "XBox"); 

		// 가전
		inputSampleProducts("TV", "홈씨어터");
		inputSampleProducts("TV", "52인치TV");
		inputSampleProducts("냉장고", "디오스");
		inputSampleProducts("선풍기", "휴대용선풍기");
		inputSampleProducts("세탁기", "LG세탁기");
		inputSampleProducts("청소기", "자동진공청소기"); 

		// 모바일
		inputSampleProducts("SKT", "SKT-iPhone");
		inputSampleProducts("KT", "KT-Gallaxy");
		inputSampleProducts("LGU+", "LGU+-iphone");
		inputSampleProducts("휴대폰주변기기", "휴대폰액세서리");
		inputSampleProducts("휴대폰주변기기", "스마트패드");
		inputSampleProducts("휴대폰주변기기", "스마트폰액정"); 

		// 레저
		inputSampleProducts("헬스", "헬스장갑");
		inputSampleProducts("요가", "요가깔개");
		inputSampleProducts("스키", "스키용품");
		inputSampleProducts("보드", "보드용품");
		inputSampleProducts("등산", "등산스틱"); 

		// 도서
		inputSampleProducts("외국어", "Eng대학교재");
		inputSampleProducts("소설", "왕좌의 게임");
		inputSampleProducts("문학", "소림사");
		inputSampleProducts("수필", "김소월시집");
		inputSampleProducts("교재", "공업수학");
		
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
		categoryMapper.insertRootCategory(new Category("여성의류"));
		categoryMapper.insertRootCategory(new Category("남성의류"));
		categoryMapper.insertRootCategory(new Category("화장품"));
		categoryMapper.insertRootCategory(new Category("잡화"));
		categoryMapper.insertRootCategory(new Category("출산/아동"));
		categoryMapper.insertRootCategory(new Category("가구"));
		categoryMapper.insertRootCategory(new Category("게임"));
		categoryMapper.insertRootCategory(new Category("가전"));
		categoryMapper.insertRootCategory(new Category("모바일"));
		categoryMapper.insertRootCategory(new Category("레저"));
		categoryMapper.insertRootCategory(new Category("도서"));
		
		Category parentCategory = categoryMapper.getCategoryByName("여성의류");
		categoryMapper.insertChildCategory(new Category(parentCategory, "여성 티셔츠"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "여성 니트류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "여성 조끼류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "원피스"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "여성 속옷"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "기타 여성복"));
		
		parentCategory = categoryMapper.getCategoryByName("남성의류");
		categoryMapper.insertChildCategory(new Category(parentCategory, "남성 티셔츠"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "남성 니트류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "남성 조끼류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "남성 자켓"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "남성 속옷"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "기타 남성복"));
	
		parentCategory = categoryMapper.getCategoryByName("화장품");
		categoryMapper.insertChildCategory(new Category(parentCategory, "메이크업"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "향수"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "바디"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "헤어"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "아로마"));
		
		parentCategory = categoryMapper.getCategoryByName("잡화");
		categoryMapper.insertChildCategory(new Category(parentCategory, "신발"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "지갑"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "벨트"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "모자"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "안경"));
		
		parentCategory = categoryMapper.getCategoryByName("출산/아동");
		categoryMapper.insertChildCategory(new Category(parentCategory, "유아의류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "신생아의류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "유아도서")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "아동의류"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "완구"));
		
		parentCategory = categoryMapper.getCategoryByName("가구");
		categoryMapper.insertChildCategory(new Category(parentCategory, "책상"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "의자"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "침대")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "쇼파"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "싱크대"));
		
		parentCategory = categoryMapper.getCategoryByName("게임");
		categoryMapper.insertChildCategory(new Category(parentCategory, "닌텐도"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "PSP"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "Wii")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "XBox")); 
		
		parentCategory = categoryMapper.getCategoryByName("가전");
		categoryMapper.insertChildCategory(new Category(parentCategory, "TV"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "냉장고"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "선풍기")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "세탁기"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "청소기"));
		
		parentCategory = categoryMapper.getCategoryByName("모바일");
		categoryMapper.insertChildCategory(new Category(parentCategory, "SKT"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "KT"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "LGU+")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "휴대폰주변기기"));
		
		parentCategory = categoryMapper.getCategoryByName("레저");
		categoryMapper.insertChildCategory(new Category(parentCategory, "헬스"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "요가"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "스키")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "보드"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "등산"));
		
		parentCategory = categoryMapper.getCategoryByName("도서");
		categoryMapper.insertChildCategory(new Category(parentCategory, "외국어"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "소설"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "문학")); 
		categoryMapper.insertChildCategory(new Category(parentCategory, "수필"));
		categoryMapper.insertChildCategory(new Category(parentCategory, "교재"));
	}

	private static void insertUser() {
		userMapper.insertUser(new User("name1@gmail.com", "1111", "name1", "010-111-1111", "ktalk1", "bio1", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name2@gmail.com", "2222", "name2", "010-222-2222", "ktalk2", "bio2", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name3@gmail.com", "3333", "name3", "010-333-3333", "ktalk3", "bio3", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name4@gmail.com", "4444", "name4", "010-444-4444", "ktalk4", "bio4", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name5@gmail.com", "5555", "name5", "010-555-5555", "ktalk5", "bio5", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name6@gmail.com", "6666", "name6", "010-666-6666", "ktalk6", "bio6", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name7@gmail.com", "7777", "name7", "010-777-7777", "ktalk7", "bio7", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name8@gmail.com", "8888", "name8", "010-888-8888", "ktalk8", "bio8", Format.getSqlDate(Format.randDate())));
		userMapper.insertUser(new User("name9@gmail.com", "9999", "name9", "010-999-9999", "ktalk9", "bio9", Format.getSqlDate(Format.randDate())));

		List<User> users = userMapper.getAllUsers();

		for (User user : users) {
			for (int i = 0; i < 4; i++) {
				String postRandomNumHead = "" + Format.randInt(100, 999);
				String postRandomNumTail = "" + Format.randInt(100, 999);
				
				AddressProc addrProc = new AddressProc(new Address(user.getUserId(), null, "detailAdd" + i, postRandomNumHead, postRandomNumTail, user.getName(), user.getPhone()));
				userMapper.insertAddressProc(addrProc);

				addrProc = new AddressProc(new Address(user.getUserId(), addrProc.getInsertedAddressId(),"detailAddRoad" + i, postRandomNumHead, postRandomNumTail, user.getName(), user.getPhone()));
				userMapper.insertAddressProc(addrProc);
			}
		}
	}

	private static void inputSampleProducts(String categoryName, String productNameHeader) {
		int categoryId = categoryMapper.getCategoryByName(categoryName).getCategoryId();
		if(categoryId <= 0 )
			return;
		
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
