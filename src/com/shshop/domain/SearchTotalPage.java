package com.shshop.domain;

import java.util.List;

public class SearchTotalPage {
	private int totalPage;
	private int totalCount;
	private List<Product> productRows = null;

	public List<Product> getproductRows() {
		return productRows;
	}

	public void setContentRows(List<Product> productRows) {
		this.productRows = productRows;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.totalPage = (totalCount / 10 + 1);
	}

	public int getTotalPage() {
		return totalPage;
	}
}
