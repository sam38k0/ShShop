package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class Product implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer productId;
	private Integer userId;
	private String name;
	private Integer price;
	private Integer stock;
	private int translation = 0; // 1:안전결재 , 2:택배
	private int connection = 1; //직접통화,SMS,카톡,이메일,쪽지,채팅,댓글
	private boolean onSale;
	private boolean onOpen;
	private String tag;
	private Date dateCreated;
	private Date dateUpdated;
	private boolean outOfStock;
	private String description;
	private User user;
	private int searchingCount = 0;

	public Product() {

	}
	 
	public Product(Integer userId, String name, int price, int stock, int translation, int connection, 
				   String tag, String description, int searchingCount,
				   boolean onSale, boolean onOpen, boolean outOfStock) {
		this.userId = userId;
		this.name = name;
		this.price = price;
		this.stock = stock;
		this.onSale = onSale;
		this.onOpen = onOpen;
		this.tag = tag;
		this.outOfStock = outOfStock;
		this.description = description;
		this.searchingCount = searchingCount;
		this.connection = connection;
		this.translation = translation;
	}
	
    @Override
    public boolean equals(Object object)
    {
        boolean sameSame = false;

        if (object != null && object instanceof Product)
        {
        	Product product = (Product) object;
        	
            sameSame = (this.getName().equalsIgnoreCase(product.getName()) &&
            			this.getUserId().equals(product.getUserId()) &&
            			this.getPrice() == product.getPrice());
        }

        return sameSame;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public boolean isOnSale() {
		return onSale;
	}

	public void setOnSale(boolean onSale) {
		this.onSale = onSale;
	}

	public boolean isOnOpen() {
		return onOpen;
	}

	public void setOnOpen(boolean onOpen) {
		this.onOpen = onOpen;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Date getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	public boolean isOutOfStock() {
		return outOfStock;
	}

	public void setOutOfStock(boolean outOfStock) {
		this.outOfStock = outOfStock;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getSearchingCount() {
		return searchingCount;
	}

	public void setSearchingCount(int searchingCount) {
		this.searchingCount = searchingCount;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public int getTranslation() {
		return translation;
	}

	public void setTranslation(int translation) {
		this.translation = translation;
	}

	public int getConnection() {
		return connection;
	}

	public void setConnection(int connection) {
		this.connection = connection;
	}
	
	public String getTranslationComment() { 
		if(translation <= 0 || translation > 2)
			return "";
		else if(translation == 1)
			return "안전결재";
		else 
			return "택배";
			
	}
	
	public String getConnectOptionComment() {
		if(connection <= 0)
			return "";
		
		int opt1 = 0x00000001;
		int opt2 = 0x00000002;
		int opt3 = 0x00000004;
		int opt4 = 0x00000008;
		int opt5 = 0x00000010;
		int opt6 = 0x00000100;
		int opt7 = 0x00001000;

		String strResult = "";
		String strOpt1 = "직접통화,";
		String strOpt2 = "SMS,";
		String strOpt3 = "카톡,";
		String strOpt4 = "이메일,";
		String strOpt5 = "쪽지,";
		String strOpt6 = "채팅,";
		String strOpt7 = "댓글,";

		if ((connection & opt1) > 0)
			strResult += strOpt1;
		if ((connection & opt2) > 0)
			strResult += strOpt2;
		if ((connection & opt3) > 0)
			strResult += strOpt3;
		if ((connection & opt4) > 0)
			strResult += strOpt4;
		if ((connection & opt5) > 0)
			strResult += strOpt5;
		if ((connection & opt6) > 0)
			strResult += strOpt6;
		if ((connection & opt7) > 0)
			strResult += strOpt7;
		if (!strResult.equals(""))
			strResult = strResult.substring(0, strResult.length() - 1);

		return strResult;
	}
}
