package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class ProductProc implements Serializable {
	private static final long serialVersionUID = 1L;
	private Product product = null;
	private Integer categoryId;
	private String imagePaths;
	private Integer insertedProductId;

	public ProductProc() {

	}
	
	public ProductProc(Integer userId, Integer categoryId, String name, int price, int stock, int translation, int connection, 
				   String tag, String description, int searchingCount,
				   boolean onSale, boolean onOpen, boolean outOfStock, String imagePaths) {
		product = new Product(userId,name,price,stock,translation,connection,tag,description,searchingCount,onSale,onOpen,outOfStock);
		this.setCategoryId(categoryId);
		this.setImagePaths(imagePaths);
	}
	
    @Override
    public boolean equals(Object object)
    {
    	return product.equals(object);
    }

	public String getName() {
		return product.getName();
	}

	public void setName(String name) {
		product.setName(name);
	}

	public int getPrice() {
		return product.getPrice();
	}

	public void setPrice(int price) {
		product.setPrice(price);
	}

	public int getStock() {
		return product.getStock();
	}

	public void setStock(int stock) {
		product.setStock(stock);
	}

	public boolean isOnSale() {
		return product.isOnSale();
	}

	public void setOnSale(boolean onSale) {
		product.setOnSale(onSale);
	}

	public boolean isOnOpen() {
		return product.isOnOpen();
	}

	public void setOnOpen(boolean onOpen) {
		product.setOnOpen(onOpen);
	}

	public String getTag() {
		return product.getTag();
	}

	public void setTag(String tag) {
		product.setTag(tag);
	}

	public Date getDateCreated() {
		return product.getDateCreated();
	}

	public void setDateCreated(Date dateCreated) {
		product.setDateCreated(dateCreated);
	}

	public Date getDateUpdated() {
		return product.getDateUpdated();
	}

	public void setDateUpdated(Date dateUpdated) {
		product.setDateUpdated(dateUpdated);
	}

	public boolean isOutOfStock() {
		return product.isOutOfStock();
	}

	public void setOutOfStock(boolean outOfStock) {
		product.setOutOfStock(outOfStock);
	}

	public String getDescription() {
		return product.getDescription();
	}

	public void setDescription(String description) {
		product.setDescription(description);
	}

	public Integer getProductId() {
		return product.getProductId();
	}

	public void setProductId(Integer productId) {
		product.setProductId(productId);
	}

	public User getUser() {
		return product.getUser();
	}

	public void setUser(User user) {
		product.setUser(user);
	}

	public int getSearchingCount() {
		return product.getSearchingCount();
	}

	public void setSearchingCount(int searchingCount) {
		product.setSearchingCount(searchingCount);
	}

	public Integer getUserId() {
		return product.getUserId();
	}

	public void setUserId(Integer userId) {
		product.setUserId(userId);
	}

	public int getTranslation() {
		return product.getTranslation();
	}

	public void setTranslation(int translation) {
		product.setTranslation(translation);
	}

	public int getConnection() {
		return product.getConnection();
	}

	public void setConnection(int connection) {
		product.setConnection(connection);
	}
	
	public String getTranslationComment() { 
		return product.getTranslationComment();
	}
	
	public String getConnectOptionComment() {
		return product.getConnectOptionComment();
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getImagePaths() {
		return imagePaths;
	}

	public void setImagePaths(String imagePaths) {
		this.imagePaths = imagePaths;
	}

	public Integer getInsertedProductId() {
		return insertedProductId;
	}

	public void setInsertedProductId(Integer insertedProductId) {
		this.insertedProductId = insertedProductId;
	}
}
