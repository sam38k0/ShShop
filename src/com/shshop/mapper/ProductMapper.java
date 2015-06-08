package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Category;
import com.shshop.domain.Product;
import com.shshop.domain.ProductOption;
import com.shshop.domain.ProductProc;

public interface ProductMapper {
	public int getProductCount();
	
	public Product getProductById(@Param("productId") Integer productId);
	
	public List<ProductOption> getProductRootOptions(@Param("productId") Integer productId);
	
	public List<Category> getProdcutCategories(@Param("productId") Integer productId);
	
	public List<Product> getSearchedProducts(@Param("keywords") String keywords);
	
	public void insertProduct(Product product);
	
	public void updateProduct(Product product);
	
	public void deleteProduct(@Param("productId") Integer productId);
	

	public List<Product> selectMainCount();
	
	public List<Product> selectMainDate();
	

	public void insertProductProc(ProductProc productProc);
}
