package com.shshop.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CategoryNodeInfos implements Serializable {
	private static final long serialVersionUID = 1L;

	private List<String> categoryLevel1 = new ArrayList<>();
	private List<String> categoryLevel2 = new ArrayList<>();
	private List<String> categoryLevel3 = new ArrayList<>();
	private List<String> categoryLevel4 = new ArrayList<>();

	public CategoryNodeInfos() {

	}

	public CategoryNodeInfos(List<String> categoryLevel1, List<String> categoryLevel2, List<String> categoryLevel3, List<String> categoryLevel4) {
		super();
		this.categoryLevel1 = categoryLevel1;
		this.categoryLevel2 = categoryLevel2;
		this.categoryLevel3 = categoryLevel3;
		this.categoryLevel4 = categoryLevel4;
	}

	public List<String> getCategoryLevel1() {
		return categoryLevel1;
	}

	public void setCategoryLevel1(List<String> categoryLevel1) {
		this.categoryLevel1 = categoryLevel1;
	}

	public List<String> getCategoryLevel2() {
		return categoryLevel2;
	}

	public void setCategoryLevel2(List<String> categoryLevel2) {
		this.categoryLevel2 = categoryLevel2;
	}

	public List<String> getCategoryLevel3() {
		return categoryLevel3;
	}

	public void setCategoryLevel3(List<String> categoryLevel3) {
		this.categoryLevel3 = categoryLevel3;
	}

	public List<String> getCategoryLevel4() {
		return categoryLevel4;
	}

	public void setCategoryLevel4(List<String> categoryLevel4) {
		this.categoryLevel4 = categoryLevel4;
	}
}
