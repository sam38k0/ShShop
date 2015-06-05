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
		userMapper = sqlSession.getMapper(UserMapper.class);
		categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		productMapper = sqlSession.getMapper(ProductMapper.class);
 
		insertUser();
		insertCategory();
		
		//�����Ƿ�
		int categoryId = 1;
		inputSampleProducts(categoryId, "(��)Ƽ����");
		inputSampleProducts(categoryId, "(��)��Ʈ");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)��Ʈ");
		inputSampleProducts(categoryId, "(��)�е�");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)���ǽ�");
		inputSampleProducts(categoryId, "(��)Ʈ���̴׺�");
		
		//�����Ƿ�
		categoryId+=1;
		inputSampleProducts(categoryId, "(��)Ƽ����");
		inputSampleProducts(categoryId, "(��)��Ʈ");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)����");
		inputSampleProducts(categoryId, "(��)��Ʈ"); 
		inputSampleProducts(categoryId, "(��)����"); 
		inputSampleProducts(categoryId, "(��)Ʈ���̴׺�");
		inputSampleProducts(categoryId, "(��)��꺹");
		
		//ȭ��ǰ
		categoryId+=1;
		inputSampleProducts(categoryId, "����ȭ��ǰ");
		inputSampleProducts(categoryId, "����ũ��");
		inputSampleProducts(categoryId, "�ٵ��ɾ�");
		inputSampleProducts(categoryId, "����ȭ��ǰ");
		inputSampleProducts(categoryId, "���");
		inputSampleProducts(categoryId, "�Ʒθ�");  
		
		//��ȭ
		categoryId+=1;
		inputSampleProducts(categoryId, "Ƽ��");
		inputSampleProducts(categoryId, "����");
		inputSampleProducts(categoryId, "�����");
		inputSampleProducts(categoryId, "��ǰ");
		inputSampleProducts(categoryId, "���ǰ");
		inputSampleProducts(categoryId, "��ǰ"); 
		inputSampleProducts(categoryId, "����ǰ");
 
		//���/�Ƶ�
		categoryId+=1;
		inputSampleProducts(categoryId, "����ǰ");
		inputSampleProducts(categoryId, "�Ż����Ƿ�");
		inputSampleProducts(categoryId, "�����Ƿ�");
		inputSampleProducts(categoryId, "���ƻ�Ȱ��ǰ");
		inputSampleProducts(categoryId, "���Ƶ���");
		inputSampleProducts(categoryId, "�ϱ�"); 
		inputSampleProducts(categoryId, "������ϱ�"); 
		inputSampleProducts(categoryId, "�Ƶ��Ƿ�");
		inputSampleProducts(categoryId, "���ھƵ��Ƿ�");
		
		//����
		categoryId+=1;
		inputSampleProducts(categoryId, "å��");
		inputSampleProducts(categoryId, "å��");
		inputSampleProducts(categoryId, "����");
		inputSampleProducts(categoryId, "ħ������");
		inputSampleProducts(categoryId, "ħ��");
		inputSampleProducts(categoryId, "�ϱ�"); 
		inputSampleProducts(categoryId, "ī��Ʈ"); 
		inputSampleProducts(categoryId, "����å��"); 
		
		//����
		categoryId+=1;
		inputSampleProducts(categoryId, "���ٵ�DS");
		inputSampleProducts(categoryId, "PSP");
		inputSampleProducts(categoryId, "PS2");
		inputSampleProducts(categoryId, "PS3");
		inputSampleProducts(categoryId, "PS4");
		inputSampleProducts(categoryId, "Wii"); 
		inputSampleProducts(categoryId, "Xbox"); 
		inputSampleProducts(categoryId, " �������"); 

		//����
		categoryId+=1;
		inputSampleProducts(categoryId, "Ȩ������");
		inputSampleProducts(categoryId, "DVD�÷��̾�");
		inputSampleProducts(categoryId, "�����");
		inputSampleProducts(categoryId, "MP3");
		inputSampleProducts(categoryId, "PMP");
		inputSampleProducts(categoryId, "�̾���"); 
		inputSampleProducts(categoryId, "����Ŀ"); 
		inputSampleProducts(categoryId, "����ũ");  
 
		//�����
		categoryId+=1;
		inputSampleProducts(categoryId, "SKT");
		inputSampleProducts(categoryId, "KT");
		inputSampleProducts(categoryId, "LGU+");
		inputSampleProducts(categoryId, "�޴����׼�����");
		inputSampleProducts(categoryId, "����Ʈ�е�");
		inputSampleProducts(categoryId, "����Ʈ������"); 
		inputSampleProducts(categoryId, "�������"); 
		inputSampleProducts(categoryId, "�޴����ֺ����");  
 
		//����
		categoryId+=1;
		inputSampleProducts(categoryId, "����ǰ");
		inputSampleProducts(categoryId, "ķ�ο�ǰ");
		inputSampleProducts(categoryId, "�ｺ�䰡��ǰ");
		inputSampleProducts(categoryId, "��Ű");
		inputSampleProducts(categoryId, "����");
		inputSampleProducts(categoryId, "������"); 
		inputSampleProducts(categoryId, "����"); 
		inputSampleProducts(categoryId, "�౸");  
		inputSampleProducts(categoryId, "�߱�");  
		inputSampleProducts(categoryId, "��");  
		inputSampleProducts(categoryId, "����");  
		inputSampleProducts(categoryId, "��������");  
 
		//����
		categoryId+=1;
		inputSampleProducts(categoryId, "���б���");
		inputSampleProducts(categoryId, "�ܱ���");
		inputSampleProducts(categoryId, "�н��Ҽ�");
		inputSampleProducts(categoryId, "���а濵");
		inputSampleProducts(categoryId, "����");
		inputSampleProducts(categoryId, "�ι�"); 
		inputSampleProducts(categoryId, "��ȸ��ǻ��"); 
		inputSampleProducts(categoryId, "���й�ȭ");  
		inputSampleProducts(categoryId, "��ȭå");  
		inputSampleProducts(categoryId, "����");  
		
		sqlSession.commit();
	}

	private static void insertCategory() {
		categoryMapper.insertRootCategory(new Category("�����Ƿ�", "�����Ƿ�Desc", "�����Ƿ�Link"));
		categoryMapper.insertRootCategory(new Category("�����Ƿ�", "�����Ƿ�Desc", "�����Ƿ�Link"));
		categoryMapper.insertRootCategory(new Category("ȭ��ǰ", "ȭ��ǰDesc", "ȭ��ǰLink"));
		categoryMapper.insertRootCategory(new Category("��ȭ", "��ȭDesc", "��ȭLink"));
		categoryMapper.insertRootCategory(new Category("���/�Ƶ�", "���/�Ƶ�Desc", "���/�Ƶ�Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link")); 
		categoryMapper.insertRootCategory(new Category("�����", "�����Desc", "�����Link")); 
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
		categoryMapper.insertRootCategory(new Category("����", "����Desc", "����Link"));
	}

	private static void insertUser() {
		userMapper.insertUser( new User("name1@gmail.com", "1111", "name1", "111-111-1111", "ktalk1", "bio1",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name2@gmail.com", "2222", "name2", "222-222-2222", "ktalk2", "bio2",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name3@gmail.com", "3333", "name3", "333-333-3333", "ktalk3", "bio3",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name4@gmail.com", "4444", "name4", "444-444-4444", "ktalk4", "bio4",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name5@gmail.com", "5555", "name5", "555-555-5555", "ktalk5", "bio5",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name6@gmail.com", "6666", "name6", "666-666-6666", "ktalk6", "bio6",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name7@gmail.com", "7777", "name7", "777-777-7777", "ktalk7", "bio7",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name8@gmail.com", "8888", "name8", "888-888-8888", "ktalk8", "bio8",Format.getSqlDate(Format.randDate()))); 
		userMapper.insertUser( new User("name9@gmail.com", "9999", "name9", "999-999-9999", "ktalk9", "bio9",Format.getSqlDate(Format.randDate())));
	}

	private static void inputSampleProducts(int categoryId, String productNameHeader) {
		StringBuilder imageStrBuilder = new StringBuilder();
		String tagNameHeader = productNameHeader + "tag";
		String descriptionHeader = productNameHeader + "desc";
		
		int count = Format.randInt(100,200);
		for (int i = 0; i < count; i++) {
			imageStrBuilder.setLength(0);
			imageStrBuilder.append("c:/100" + i + ".png,");
			imageStrBuilder.append("c:/200" + i + ".png,");
			imageStrBuilder.append("c:/300" + i + ".png,");
			imageStrBuilder.append("c:/400" + i + ".png");
			productMapper.insertProductProc(new ProductProc(Format.randInt(1,9), categoryId,
															productNameHeader+i, 100 * (i + 1),Format.randInt(1,1000), i%2 + 1, 204,
															tagNameHeader +i, descriptionHeader +i,Format.randInt(1, 10000),true,true,false,
															imageStrBuilder.toString()));  
		}
	}
}
