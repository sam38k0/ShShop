package com.shshop.response;

import java.util.ArrayList;
import java.util.List;

public class SearchResult {
	private static final int sortByDate = 1;
	private static final int sortByHit = 2;
	private static final int sortByHighPrice = 3;
	private static final int sortByLowPrice = 4;
	
	private int pageDivNum = 2;
	private int currentPage = 0;
	private List<SearchResultParam> searchResults = null;
	private String keywords = "";
	private int sortCondition = sortByDate;
	
	public SearchResult(int currentPage, String keyword, int sortCondition, List<SearchResultParam> searchResults) {
		this.currentPage = currentPage;
		this.keywords = keyword;
		this.searchResults = searchResults;
		setSortCondition(sortCondition);
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

	public int getSortCondition() {
		return sortCondition;
	}

	public void setSortCondition(int sortCondition) {
		if(sortCondition > sortByLowPrice || sortCondition < sortByDate) {
			return;
		}
		this.sortCondition = sortCondition;
	}
}
