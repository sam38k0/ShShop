package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Product;
import com.shshop.domain.ProductOption;

public interface ProductMapper {
	public int getProductCount();
	
	public Product getProductById(@Param("productId") Integer productId);
	
	public List<ProductOption> getProductRootOptions(@Param("productId") Integer productId);
	
	public void insertProduct(Product product);
	
	public void updateProduct(Product product);
	
	public void deleteProduct(@Param("productId") Integer productId);
	
}
