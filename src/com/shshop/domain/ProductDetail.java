package com.shshop.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ProductDetail implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Product product = null;
	private User productOwner = null;
	
	private List<String> imagePaths = new ArrayList<>();

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public void addImagePath(String imagePath) {
		getImagePaths().add(imagePath);
	}

	public boolean hasImagePaths() {
		return !getImagePaths().isEmpty();
	}

	public List<String> getImagePaths() {
		return imagePaths;
	}

	public void setImagePaths(List<String> imagePaths) {
		this.imagePaths = imagePaths;
	}

	public User getProductOwner() {
		return productOwner;
	}

	public void setProductOwner(User productOwner) {
		this.productOwner = productOwner;
	}

}
