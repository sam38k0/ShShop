package com.shshop.domain;

import java.io.Serializable;

public class ProductImage implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer imageId;
	private Integer productId;
	private String imagePath;
	
	public ProductImage() {
		
	}
	
	public ProductImage(Integer productId, String imagePath ) {
		this.setProductId(productId);
		this.setImagePath(imagePath);
	}

	public Integer getImageId() {
		return imageId;
	}

	public void setImageId(Integer imageId) {
		this.imageId = imageId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
}