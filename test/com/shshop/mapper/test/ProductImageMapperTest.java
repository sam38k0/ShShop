package com.shshop.mapper.test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.ProductImage;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.util.MyBatisUtil;

public class ProductImageMapperTest {
	SqlSession sqlSession = null;
	ProductImageMapper imageMapper = null;
	
	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		imageMapper = sqlSession.getMapper(ProductImageMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testGetProductImageCount() {
		int iCount = imageMapper.getProductImageCount();
		assertNotNull("testGetProductImageCount", iCount != 0);
	}

	@Test
	public void testGetImageById() {
		ProductImage image = imageMapper.getImageById(1);
		assertNotNull("testGetImageById", image);
	}

	@Test
	public void testGetProductImages() {
		List<ProductImage> images = imageMapper.getProductImages(1);
		assertTrue("testGetProductImages", images.size() > 0);
	}

	@Test
	public void testInsertImage() {
		int iCountBefore = imageMapper.getProductImageCount();
		ProductImage image = new ProductImage(1,"c:\test\testpath.png");
		ProductImage image2 = new ProductImage(1,"c:\test\testpath2.png");
		imageMapper.insertImage(image);
		imageMapper.insertImage(image2);
		int iCountAfter = imageMapper.getProductImageCount();
		assertTrue("testInsertImage", iCountBefore + 2 == iCountAfter);
	}

	@Test
	public void testUpdateImage() {
		ProductImage image = imageMapper.getImageById(1);
		image.setImagePath("ttt");
		
		imageMapper.updateImage(image);
		 
		image = imageMapper.getImageById(1);
		assertTrue("testUpdateImage", image.getImagePath().equalsIgnoreCase("ttt"));
	}

	@Test
	public void testDeleteImage() {
		int countBefore = imageMapper.getProductImageCount();
		imageMapper.deleteImage(1);
		imageMapper.deleteImage(2);
		int countAfter = imageMapper.getProductImageCount();
		assertTrue("testDeleteImage", countBefore > countAfter+1);
	}
}
