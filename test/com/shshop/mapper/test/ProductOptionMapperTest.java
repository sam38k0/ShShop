package com.shshop.mapper.test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.ProductOption;
import com.shshop.mapper.ProductOptionMapper;
import com.shshop.util.MyBatisUtil;

public class ProductOptionMapperTest {

	SqlSession sqlSession = null;
	ProductOptionMapper productOptMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		productOptMapper = sqlSession.getMapper(ProductOptionMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}
 
	@Test
	public void testGetOptionById() {
		ProductOption psOption = productOptMapper.getOptionById(1);
		assertNotNull("testGetCategoryById", psOption);
	}

	@Test
	public void testGetChildrenOptions() {
		ProductOption psOptionRoot = new ProductOption(1,"test");
		
		List<ProductOption> psChildOptions = productOptMapper.getChildrenOptions(psOptionRoot);
		assertTrue("testGetChildrenOptions", psChildOptions.size() > 0);
	}

	@Test
	public void testUpdateOption() {
		ProductOption productOpt = productOptMapper.getOptionById(1);
		productOpt.setOptionName("testName$");
		productOptMapper.updateOption(productOpt);
		productOpt = productOptMapper.getOptionById(1);
		assertTrue("testUpdateCategory1", productOpt.getOptionName().equalsIgnoreCase("testName$")); 
	}

	@Test
	public void testDeleteOption() {
		int countBefore = productOptMapper.getOptionCount();
		productOptMapper.deleteOption(2);
		int countAfter = productOptMapper.getOptionCount();
		assertTrue("testDeleteCategory", countBefore > countAfter+1);
	}
}
