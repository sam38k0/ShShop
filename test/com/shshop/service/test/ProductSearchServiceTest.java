package com.shshop.service.test;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;

import com.shshop.domain.Product;
import com.shshop.service.ProductSearchService;

public class ProductSearchServiceTest {

	@Test
	public void testgetSearch() {
		ProductSearchService productSearchService = new ProductSearchService();
//		productSearchService.getSearch("pro");
		List<Product> products = productSearchService.getSearching("pro");
		assertTrue("testgetSearch",products.size()>0);
	}
	
}
