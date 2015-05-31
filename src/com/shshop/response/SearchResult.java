package com.shshop.response;

import java.util.ArrayList;
import java.util.List;

public class SearchResult {
	private int pageDivNum = 2;
	private int currentPage = 0;
	private List<SearchResultParam> searchResults = null;
	private String keywords = "";
	
	public SearchResult(int currentPage, String keyword, List<SearchResultParam> searchResults) {
		this.currentPage = currentPage;
		this.keywords = keyword;
		this.searchResults = searchResults;
	}
 
	public int getTotalSize() {
		return searchResults.size();
	}
	
	public int getTotalPageCount() {
		return (searchResults.size() / pageDivNum) + 1;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}

	public List<SearchResultParam> getCurrentPageResult() {
		List<SearchResultParam> currentResult = new ArrayList<>();
		 
		int startIndex = (currentPage-1) * pageDivNum;
		int lastIndex = currentPage * pageDivNum;
		if(searchResults.size() < lastIndex)
			lastIndex = searchResults.size();
		
		for (int i = startIndex; i < lastIndex; i++) {
			currentResult.add(searchResults.get(i));
		}

		return currentResult;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keyword) {
		this.keywords = keyword;
	}
}
