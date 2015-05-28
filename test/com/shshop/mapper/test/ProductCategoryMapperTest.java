package com.shshop.mapper.test;

import static org.junit.Assert.fail;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.ProductCategory;
import com.shshop.mapper.ProductCategoryMapper;
import com.shshop.util.MyBatisUtil;

public class ProductCategoryMapperTest {
	SqlSession sqlSession = null;
	ProductCategoryMapper productCategoryMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		productCategoryMapper = sqlSession.getMapper(ProductCategoryMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testInsertProductCategory() {
		ProductCategory productAndCategory = new ProductCategory(1,1);
		try{
			productCategoryMapper.insertProductCategory(productAndCategory);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		fail("testInsertProductCategory");
	} 
}
