package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class Category implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer categoryId;
	private Integer parentCategoryId;
	private String name;
	private String link;
	private boolean isRootCategory;
	private String description;
	private Date dateCreated;
	private Date dateUpdated;

	public Category() {

	}

	//For Child Category
	public Category(Category parentCategory, String name, String description, String link) {
		this.parentCategoryId = parentCategory.getCategoryId();
		this.name = name;
		this.description = description;
		this.link = link;
		this.isRootCategory = false;
	}

	//For Root Category
	public Category(String name, String description, String link) {
		this.name = name;
		this.description = description;
		this.link = link;
		this.isRootCategory = true;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public boolean isRootCategory() {
		return isRootCategory;
	}

	public void setRootCategory(boolean isRootCategory) {
		this.isRootCategory = isRootCategory;
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
