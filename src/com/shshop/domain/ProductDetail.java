package com.shshop.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ProductDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	private Product product = null;
	private User productOwner = null;
	private String postResults = "";
	private int productOwnerItemCount = 0;
	private String productOwnerBasicAddress = "";

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

	public String getPostResults() {
		return postResults;
	}

	public void setPostResults(String postResults) {
		this.postResults = postResults;
	}

	public int getProductOwnerItemCount() {
		return productOwnerItemCount;
	}

	public void setProductOwnerItemCount(int productOwnerOrderCount) {
		this.productOwnerItemCount = productOwnerOrderCount;
	}

	public String getProductOwnerBasicAddress() {
		return productOwnerBasicAddress;
	}

	public void setProductOwnerBasicAddress(String basicAddress, String detailAddress) {
		this.productOwnerBasicAddress = basicAddress + " " + detailAddress;
	}

}
