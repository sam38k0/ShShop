package com.shshop.sample;

import org.apache.ibatis.session.SqlSession;

import com.shshop.domain.Category;
import com.shshop.domain.ProductProc;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

public class BuildSampleData {
	static SqlSession sqlSession = null;
	static ProductMapper productMapper = null;
	static UserMapper userMapper = null;
	static CategoryMapper categoryMapper = null;
	
	public static void main(String[] args) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		//Insert User
		userMapper = sqlSession.getMapper(UserMapper.class);
		userMapper.insertUserByEmail( new User("name1@gmail.com", "1111", "name1", "111-111-1111", "ktalk1", "bio1",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name2@gmail.com", "2222", "name2", "222-222-2222", "ktalk2", "bio2",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name3@gmail.com", "3333", "name3", "333-333-3333", "ktalk3", "bio3",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name4@gmail.com", "4444", "name4", "444-444-4444", "ktalk4", "bio4",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name5@gmail.com", "5555", "name5", "555-555-5555", "ktalk5", "bio5",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name6@gmail.com", "6666", "name6", "666-666-6666", "ktalk6", "bio6",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name7@gmail.com", "7777", "name7", "777-777-7777", "ktalk7", "bio7",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name8@gmail.com", "8888", "name8", "888-888-8888", "ktalk8", "bio8",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUserByEmail( new User("name9@gmail.com", "9999", "name9", "999-999-9999", "ktalk9", "bio9",Format.getSqlDate(Format.randDate())));
		
		//Insert Category
		categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		categoryMapper.insertRootCategory(new Category("여성의류", "여성의류Desc", "여성의류Link"));
		categoryMapper.insertRootCategory(new Category("남성의류", "남성의류Desc", "남성의류Link"));
		categoryMapper.insertRootCategory(new Category("잡화", "잡화Desc", "잡화Link"));
		categoryMapper.insertRootCategory(new Category("출산/아동", "출산/아동Desc", "출산/아동Link"));
		categoryMapper.insertRootCategory(new Category("가구", "가구Desc", "가구Link"));
		categoryMapper.insertRootCategory(new Category("리빙", "리빙Desc", "리빙Link"));
		categoryMapper.insertRootCategory(new Category("가전", "가전Desc", "가전Link"));
		categoryMapper.insertRootCategory(new Category("사무기기", "사무기기Desc", "사무기기Link"));
		categoryMapper.insertRootCategory(new Category("카메라", "카메라Desc", "카메라Link"));
		categoryMapper.insertRootCategory(new Category("모바일", "모바일Desc", "모바일Link"));
		categoryMapper.insertRootCategory(new Category("음반,DVD", "음반,DVDDesc", "음반,DVDLink"));
		categoryMapper.insertRootCategory(new Category("음향,악기", "음향,악기Desc", "음향,악기Link"));
		categoryMapper.insertRootCategory(new Category("게임", "게임Desc", "게임Link"));
		categoryMapper.insertRootCategory(new Category("레저", "레저Desc", "레저Link"));
		categoryMapper.insertRootCategory(new Category("도서", "도서Desc", "도서Link"));
		categoryMapper.insertRootCategory(new Category("티켓", "티켓Desc", "티켓Link"));
		categoryMapper.insertRootCategory(new Category("자동차", "자동차Desc", "자동차Link"));
		categoryMapper.insertRootCategory(new Category("애완", "애완Desc", "애완Link"));
		categoryMapper.insertRootCategory(new Category("기타", "기타Desc", "기타Link"));
		
		//Insert Product
		productMapper = sqlSession.getMapper(ProductMapper.class);
		StringBuilder imageStrBuilder = new StringBuilder();
		for (int i = 0; i < 1000; i++) {
			imageStrBuilder.setLength(0);
			imageStrBuilder.append("c:/100" + i + ".png,");
			imageStrBuilder.append("c:/200" + i + ".png,");
			imageStrBuilder.append("c:/300" + i + ".png,");
			imageStrBuilder.append("c:/400" + i + ".png");
			productMapper.insertProductProc(new ProductProc(Format.randInt(1,9), Format.randInt(1,19),
												"product"+i, 100 * (i + 1),Format.randInt(1,1000), i%2 + 1, 204,
												"tag" +i, "description" +i,Format.randInt(1, 10000),true,true,false,
												imageStrBuilder.toString()));  
		}
		
		sqlSession.commit();
	}
}
