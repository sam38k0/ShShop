package com.shshop.helper;

import java.util.ArrayList;
import java.util.List;

import com.oreilly.servlet.MultipartRequest;
import com.shshop.domain.Product;

public class InsertProductParams {
	private MultipartRequest multi = null;
	private String productName = "";
	private String description = "";
	private String tags = "";
	private String category = "";
	private int price = 0;
	private int stock = 0;
	private int transactionType = 0;
	private int connectionOpt = 0;

	public InsertProductParams(MultipartRequest multi) {
		this.multi = multi;
		getParams();
	}

	private void getParams() {
		productName = multi.getParameter("productname");
		description = multi.getParameter("description");
		tags = multi.getParameter("tagsinput");
		category = multi.getParameter("miniCategory");
		price = Integer.parseInt(multi.getParameter("price"));
		stock = Integer.parseInt(multi.getParameter("stock"));
		transactionType = Integer.parseInt(multi.getParameter("transactionType"));

		List<String> paramNames = new ArrayList<>();
		paramNames.add("connectionOpt1");
		paramNames.add("connectionOpt2");
		paramNames.add("connectionOpt3");
		paramNames.add("connectionOpt4");
		paramNames.add("connectionOpt5");
		paramNames.add("connectionOpt6");
		paramNames.add("connectionOpt7");

		for (int i = 0; i < paramNames.size(); i++) {
			String pramValue = multi.getParameter(paramNames.get(i));
			if (pramValue != null)
				setConnectionOpt(getConnectionOpt() + Integer.parseInt(pramValue));
		}

		System.out.println(getConnectOption(getConnectionOpt()));
	}

	private String getConnectOption(int connectionOpt) {
		int opt1 = 0x00000001;
		int opt2 = 0x00000002;
		int opt3 = 0x00000004;
		int opt4 = 0x00000008;
		int opt5 = 0x00000010;
		int opt6 = 0x00000100;
		int opt7 = 0x00001000;

		String strResult = "";
		String strOpt1 = "직접통화 ,";
		String strOpt2 = "SMS ,";
		String strOpt3 = "카톡 ,";
		String strOpt4 = "이메일 ,";
		String strOpt5 = "쪽지 ,";
		String strOpt6 = "채팅 ,";
		String strOpt7 = "댓글 ,";

		if ((connectionOpt & opt1) > 0)
			strResult += strOpt1;
		if ((connectionOpt & opt2) > 0)
			strResult += strOpt2;
		if ((connectionOpt & opt3) > 0)
			strResult += strOpt3;
		if ((connectionOpt & opt4) > 0)
			strResult += strOpt4;
		if ((connectionOpt & opt5) > 0)
			strResult += strOpt5;
		if ((connectionOpt & opt6) > 0)
			strResult += strOpt6;
		if ((connectionOpt & opt7) > 0)
			strResult += strOpt7;
		if (!strResult.equals(""))
			strResult = strResult.substring(0, strResult.length() - 2);

		return strResult;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productname) {
		this.productName = productname;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(int transactionType) {
		this.transactionType = transactionType;
	}

	public int getConnectionOpt() {
		return connectionOpt;
	}

	public void setConnectionOpt(int connectionOpt) {
		this.connectionOpt = connectionOpt;
	}
}
