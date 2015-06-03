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
		categoryMapper.insertRootCategory(new Category("�����Ƿ�", "�����Ƿ�Desc", "�����Ƿ�Link"));
		categoryMapper.insertRootCategory(new Category("�����Ƿ�", "�����Ƿ�Desc", "�����Ƿ�Link"));
		categoryMapper.insertRootCategory(new Category("��ȭ", "��ȭDesc", "��ȭLink"));
		categoryMapper.insertRootCategory(new Category("���/�Ƶ�", "���/�Ƶ�Desc", "���/�Ƶ�Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("�繫���", "�繫���Desc", "�繫���Link"));
		categoryMapper.insertRootCategory(new Category("ī�޶�", "ī�޶�Desc", "ī�޶�Link"));
		categoryMapper.insertRootCategory(new Category("�����", "�����Desc", "�����Link"));
		categoryMapper.insertRootCategory(new Category("����,DVD", "����,DVDDesc", "����,DVDLink"));
		categoryMapper.insertRootCategory(new Category("����,�Ǳ�", "����,�Ǳ�Desc", "����,�Ǳ�Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("Ƽ��", "Ƽ��Desc", "Ƽ��Link"));
		categoryMapper.insertRootCategory(new Category("�ڵ���", "�ڵ���Desc", "�ڵ���Link"));
		categoryMapper.insertRootCategory(new Category("�ֿ�", "�ֿ�Desc", "�ֿ�Link"));
		categoryMapper.insertRootCategory(new Category("��Ÿ", "��ŸDesc", "��ŸLink"));
		
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
