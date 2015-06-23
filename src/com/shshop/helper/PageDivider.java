package com.shshop.helper;

import java.util.ArrayList;
import java.util.List;

public class PageDivider<T> {
	private int pageDivNum = 10;
	private int currentPage = 0;
	private List<T> datas = null;  

	public PageDivider(int currentPage, int pageDivNum, List<T> datas) {
		this.currentPage = currentPage; 
		this.datas = datas;
		this.pageDivNum = pageDivNum;
	}
	
	public List<T> getCurrentPageData() {
		return getPageData(currentPage);
	}
	
	public List<T> getPageData(int page) { // 1 페이지부터 시작..
		if(page <= 0)
			return null;
		
		List<T> result = new ArrayList<>();
		
		int startIndex = (page - 1) * pageDivNum;
		int lastIndex = page * pageDivNum;
		if (datas.size() < lastIndex)
			lastIndex = datas.size();

		for (int i = startIndex; i < lastIndex; i++) {
			result.add(datas.get(i));
		}

		return result;
	}

	public int getTotalSize() {
		return datas.size();
	}

	public int getTotalPageCount() {
		return (datas.size() / pageDivNum) + 1;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}
 
	public int getPageDivNum() {
		return pageDivNum;
	}

	public void setPageDivNum(int pageDivNum) {
		this.pageDivNum = pageDivNum;
	}
}
