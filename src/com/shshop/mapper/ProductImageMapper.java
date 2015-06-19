package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.ProductImage;

public interface ProductImageMapper {
	public int getProductImageCount();

	public ProductImage getImageById(@Param("imageId") int imageId);

	public List<ProductImage> getProductImages(@Param("productId") int productId);

	public void insertImage(ProductImage image);

	public void updateImage(ProductImage image);

	public void deleteImage(@Param("imageId") int imageId);
}
