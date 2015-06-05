package com.shshop.response;

import java.util.HashMap;
import java.util.Map;

public class ProductSearchResultManager {
	private Map<String, ProductSearchResult> searchResultMap = new HashMap<>();
	
	public void addSearchResult(String keywords, ProductSearchResult searchResult) {
		if(!searchResultMap.containsKey(keywords)) {
			searchResultMap.put(keywords, searchResult);
		}
	}
	
	public ProductSearchResult getSearchResult(String keywords) {
		ProductSearchResult result = null;
		
		if(searchResultMap.containsKey(keywords)) {
			result = searchResultMap.get(keywords);
		}
		
		return result;
	}
}
