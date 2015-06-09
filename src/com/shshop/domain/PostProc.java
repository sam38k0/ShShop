package com.shshop.domain;

import java.sql.Date;

public class PostProc {
	private Post post;
	private User user;
	private Product product;
	private Integer insertedPostId;
	
	public PostProc() {
		
	}
	
	public PostProc(Post post, User user, Product product) {
		this.post = post;
		this.user = user;
		this.product = product;
	}
	
	public Integer getPostId() {
		return post.getPostId();
	}

	public void setPostId(Integer postId) {
		post.setPostId(postId);
	}

	public Integer getBoardId() {
		return post.getBoardId();
	}

	public void setBoardId(Integer boardId) {
		post.setBoardId(boardId);
	}

	public String getComment() {
		return post.getComment();
	}

	public void setComment(String comment) {
		post.setComment(comment);
	}

	public Date getDateCreated() {
		return post.getDateCreated();
	}

	public void setDateCreated(Date dateCreated) {
		post.setDateCreated(dateCreated);
	}

	public Integer getPostParentId() {
		return post.getPostParentId();
	}

	public void setPostParentId(Integer postParentId) {
		post.setPostParentId(postParentId);
	}

	public Integer getNodePosition() {
		return post.getNodePosition();
	}

	public void setNodePosition(Integer nodePosition) {
		post.setNodePosition(nodePosition);
	}    
	
	public Integer getUserId() {
		return user.getUserId();
	}
	
	public Integer getProductId() {
		return product.getProductId();
	}

	public Integer getInsertedPostId() {
		return insertedPostId;
	}

	public void setInsertedPostId(Integer insertedPostId) {
		this.insertedPostId = insertedPostId;
	}
}
