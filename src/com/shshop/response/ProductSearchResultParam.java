package com.shshop.response;

import com.shshop.domain.Product;
import com.shshop.domain.User;

public class ProductSearchResultParam {
	private String userName = "";
	private String productName = "";
	private int price = 0;
	private String dataCreated = null;
	private boolean safeOrder = false;
	private String imageUrl = "";
	private String location = "";
	private String userLevel = "";
	private int hitCount = 0;

	public ProductSearchResultParam() {

	}
	
	public ProductSearchResultParam(String userName, String productName, int price, String dataCreated, boolean safeOrder,
							 String imageUrl, String location, String userLevel, int hitCount){
		this.userName = userName;
		this.productName = productName;
		this.price = price;
		this.dataCreated = dataCreated;
		this.safeOrder = safeOrder;
		this.imageUrl = imageUrl;
		this.location = location;
		this.userLevel = userLevel;
		this.hitCount = hitCount;
	}

	public ProductSearchResultParam(User user, Product product, String imageUrl) {
		this.setUserName(user.getName());
		this.setProductName(product.getName());
		this.setPrice(product.getPrice());
		this.setDataCreated(product.getDateCreated().toString());
		this.setImageUrl(imageUrl);
		this.setHitCount(product.getSearchingCount());
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDataCreated() {
		return dataCreated;
	}

	public void setDataCreated(String dataCreated) {
		this.dataCreated = dataCreated;
	}

	public boolean isSafeOrder() {
		return safeOrder;
	}

	public void setSafeOrder(boolean safeOrder) {
		this.safeOrder = safeOrder;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	
	public int getHitCount() {
		return hitCount;
	}
	
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
}
