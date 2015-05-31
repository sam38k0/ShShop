package com.shshop.response;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

public class ProductSearchResult {
	private static final int sortByDate = 1;
	private static final int sortByHit = 2;
	private static final int sortByHighPrice = 3;
	private static final int sortByLowPrice = 4;

	private int pageDivNum = 10;
	private int currentPage = 0;
	private List<ProductSearchResultParam> searchResults = null;
	private String keywords = "";
	private int sortCondition = sortByDate;

	public ProductSearchResult(int currentPage, String keyword, int sortCondition, List<ProductSearchResultParam> searchResults) {
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

	public List<ProductSearchResultParam> getCurrentPageResult() {
		List<ProductSearchResultParam> currentResult = new ArrayList<>();

		int startIndex = (currentPage - 1) * pageDivNum;
		int lastIndex = currentPage * pageDivNum;
		if (searchResults.size() < lastIndex)
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
		if (sortCondition > sortByLowPrice || sortCondition < sortByDate) {
			return;
		}

		this.sortCondition = sortCondition;
		sortResults(sortCondition);
	}

	private void sortResults(int sortCondition) {
		switch (sortCondition) {
		case sortByDate:
			searchResults.sort(ProductSearchResult.sortByDateComp);
			break;
		case sortByHit:
			searchResults.sort(ProductSearchResult.sortByHitComp);
			break;
		case sortByHighPrice:
			searchResults.sort(ProductSearchResult.sortByHighPriceComp);
			break;
		case sortByLowPrice:
			searchResults.sort(ProductSearchResult.sortByLowPriceComp);
		}
	}

	public static Comparator<ProductSearchResultParam> sortByDateComp = new Comparator<ProductSearchResultParam>() {
		public int compare(ProductSearchResultParam param1, ProductSearchResultParam param2) {
			SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" );
			Date day1 = null;
			Date day2 = null;
			try {
				day1 = format.parse( param1.getDataCreated() );
				day2 = format.parse( param2.getDataCreated() );
			} catch (ParseException e) {
			e.printStackTrace();
			}
			return day2.compareTo( day1 );
		}
	};

	public static Comparator<ProductSearchResultParam> sortByHitComp = new Comparator<ProductSearchResultParam>() {
		public int compare(ProductSearchResultParam param1, ProductSearchResultParam param2) {
			Integer hit1 = param1.getHitCount();
			Integer hit2 = param2.getHitCount();
			return hit1.compareTo(hit2);
		}
	};

	public static Comparator<ProductSearchResultParam> sortByLowPriceComp = new Comparator<ProductSearchResultParam>() {
		public int compare(ProductSearchResultParam param1, ProductSearchResultParam param2) {
			Integer price1 = param1.getPrice();
			Integer price2 = param2.getPrice();
			return price1.compareTo(price2);
		}
	};

	public static Comparator<ProductSearchResultParam> sortByHighPriceComp = new Comparator<ProductSearchResultParam>() {
		public int compare(ProductSearchResultParam param1, ProductSearchResultParam param2) {
			Integer price1 = param1.getPrice();
			Integer price2 = param2.getPrice();
			return price2.compareTo(price1);
		}
	};
}
