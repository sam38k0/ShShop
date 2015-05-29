package com.shshop.domain;

import java.io.Serializable;

public class ProductCategory implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer productCategoryId;
	private Integer productId;
	private Integer categoryId;

	public ProductCategory() {

	}

	public ProductCategory(Integer categoryId, Integer productId) {
		this.productId = productId;
		this.categoryId = categoryId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getProductCategoryId() {
		return productCategoryId;
	}

	public void setProductCategoryId(Integer productCategoryId) {
		this.productCategoryId = productCategoryId;
	}
}
