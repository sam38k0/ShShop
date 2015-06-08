package com.shshop.domain;

import java.io.Serializable;
import java.sql.Date;

public class Post implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer postId;
	private Integer boardId;
	private String  comment;
	private Date dateCreated;
	private Integer postParentId;
	private Integer nodePosition;

	public Post() {
		
	}
	
	public Post(Integer boardId, String comment) {
		this.setBoardId(boardId);
		this.setComment(comment);
	}

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public Integer getBoardId() {
		return boardId;
	}

	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Integer getPostParentId() {
		return postParentId;
	}

	public void setPostParentId(Integer postParentId) {
		this.postParentId = postParentId;
	}

	public Integer getNodePosition() {
		return nodePosition;
	}

	public void setNodePosition(Integer nodePosition) {
		this.nodePosition = nodePosition;
	}    
}
