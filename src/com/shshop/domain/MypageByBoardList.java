package com.shshop.domain;

import java.util.ArrayList;
import java.util.List;

import com.shshop.helper.PageDivider;

public class MypageByBoardList {
	private List<Product> products = new ArrayList<>();
	private PageDivider<Product> pageDivider = null;
	
	public MypageByBoardList(List<Product> products, int currentPage, int pageDivNum) {
		this.setProducts(products);
		this.createPageDivider(currentPage, pageDivNum);
	}
	
	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<Product> getCurrentPageOrderInfos() {
		return getPageDivider().getCurrentPageData();
	}

	public void setCurrentPageOrderInfos(List<Product> newProductInfo) {
		int currentPage = getPageDivider().getCurrentPage();
		int pageDivNum = getPageDivider().getPageDivNum();
		
		int startIndex = (currentPage - 1) * pageDivNum;
		
		//Replace Data
		for(int i=0; i< newProductInfo.size(); i++) {
			Product productInfo = products.get(startIndex + i);
			productInfo = newProductInfo.get(i); 
		}
	}
	
	public void setCurrentPage(int currentPage) {
		if(currentPage <= 0)
			currentPage = 1;
		
		getPageDivider().setCurrentPage(currentPage);
	}
	
	private void createPageDivider(int currentPage, int pageDivNum) {
		setPageDivider(new PageDivider<Product>(currentPage, pageDivNum, products));
	}
	
	public PageDivider<Product> getPageDivider() {
		return pageDivider;
	}
	
	public void setPageDivider(PageDivider<Product> pageDivider) {
		this.pageDivider = pageDivider;
	}
}
