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
