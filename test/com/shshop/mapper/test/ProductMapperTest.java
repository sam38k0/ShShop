package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Product;
import com.shshop.domain.ProductOption;
import com.shshop.mapper.ProductMapper;
import com.shshop.util.MyBatisUtil;

public class ProductMapperTest {

	SqlSession sqlSession = null;
	ProductMapper productMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		productMapper = sqlSession.getMapper(ProductMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testGetProductById() {
		Product product = productMapper.getProductById(1);
		assertNotNull("testGetProductById", product);
	}

	@Test
	public void testInsertProduct() {
		int countBefore = productMapper.getProductCount();
		productMapper.insertProduct(new Product(3, "product6", 60, 60, 1, 204, "tag8", "description6", 0, true, true, false));
		productMapper.insertProduct(new Product(1, "product7", 70, 70, 2, 3, null, "description7", 10, true, false, false));

		int countAfter = productMapper.getProductCount();
		assertEquals("testInsertProduct", countBefore + 2, countAfter);
	}

	@Test
	public void testUpdateProduct() {
		Product product = productMapper.getProductById(1);
		product.setName("newName");
		productMapper.updateProduct(product);
		product = productMapper.getProductById(1);
		assertTrue("testUpdateProduct", product.getName().equalsIgnoreCase("newName"));
	}

	@Test
	public void testDeleteProduct() {
		int countBefore = productMapper.getProductCount();
		productMapper.deleteProduct(1);
		int countAfter = productMapper.getProductCount();
		assertEquals("testInsertProduct", countBefore-1, countAfter);
	}
	
	@Test
	public void testGetProductRootOptions() {
		List<ProductOption> productOpts = productMapper.getProductRootOptions(1);
		
		assertTrue("testUpdateProduct", productOpts.size() > 0 );
	}
	
	@Test
	public void testGetSearchedProducts() {
		productMapper.insertProduct(new Product(3, "JJJJregNameJJJJ", 60, 60, 1, 204, "tag8", "description6", 0, true, true, false));
		productMapper.insertProduct(new Product(1, "product7", 70, 70, 2, 3, null, "regTagSSSSS", 10, true, false, false));
		productMapper.insertProduct(new Product(3, "product6", 60, 60, 1, 204, "tag8", "RRRRRregDesc", 0, true, true, false));
		productMapper.insertProduct(new Product(1, "asdfasdfasdf����asdfasdfafd", 70, 70, 2, 3, null, "description7", 10, true, false, false));

		List<Product> results = productMapper.getSearchedProducts("regName|regTag|regDesc|����");
		
		assertEquals("testGetSearchedProducts", results.size(), 4);
	}
}
