package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer categoryId;
	private Integer parentCategoryId;
	private String name;
	private Date dateCreated;
	private Date dateUpdated;

	public Category() {

	}

	// For Child Category
	public Category(Category parentCategory, String name) {
		this.parentCategoryId = parentCategory.getCategoryId();
		this.name = name;
	}

	// For Root Category
	public Category(String name) {
		this.name = name;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Date getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	public Integer getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(Integer parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}
}
