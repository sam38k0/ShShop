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
import com.shshop.domain.ProductProc;
import com.shshop.mapper.ProductCategoryMapper;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.util.MyBatisUtil;

public class ProductMapperTest {

	SqlSession sqlSession = null;
	ProductMapper productMapper = null;
	ProductImageMapper imageMapper = null;
	ProductCategoryMapper productCategoryMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		productMapper = sqlSession.getMapper(ProductMapper.class);
		imageMapper = sqlSession.getMapper(ProductImageMapper.class);
		productCategoryMapper = sqlSession.getMapper(ProductCategoryMapper.class);
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
	public void testGetSearchedProducts() {
		productMapper.insertProduct(new Product(3, "JJJJregNameJJJJ", 60, 60, 1, 204, "tag8", "description6", 0, true, true, false));
		productMapper.insertProduct(new Product(1, "product7", 70, 70, 2, 3, null, "regTagSSSSS", 10, true, false, false));
		productMapper.insertProduct(new Product(3, "product6", 60, 60, 1, 204, "tag8", "RRRRRregDesc", 0, true, true, false));

		List<Product> results = productMapper.getSearchedProducts("regName|regTag|regDesc");
		
		assertEquals("testGetSearchedProducts", results.size(), 3);
	}
	
	@Test
	public void testInsertProductProc() {
		int procCountBefore = productMapper.getProductCount();
		int catProcCountBefore = productCategoryMapper.getProductCategoryCount();
		int imageCountBefore = imageMapper.getProductImageCount();
		ProductProc productProc = new ProductProc(1, 1, "product6", 60, 60, 1, 204, "tag8", "description6", 0, true, true, false,"c:/1.png,c:/2.png,c:/3.png");
		productMapper.insertProductProc(productProc);
		int procCountAfter = productMapper.getProductCount();
		int catProcCountAfter = productCategoryMapper.getProductCategoryCount();
		int imageCountAfter = imageMapper.getProductImageCount(); 
		assertTrue("testInsertProductProc0", productProc.getInsertedProductId() > 0);
		assertEquals("testInsertProductProc1", procCountBefore + 1, procCountAfter);
		assertEquals("testInsertProductProc2", catProcCountBefore + 1, catProcCountAfter);
		assertEquals("testInsertProductProc3", imageCountBefore + 3, imageCountAfter);
	}
}
