package com.shshop.domain;

public class ProductSearch {
	private String keyword;
	
	public ProductSearch(){
		
	}
	public ProductSearch(String keyword){
		this.keyword = keyword;
	}

	public String getKeyword() {
//		return "%" + keyword + "%";
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
