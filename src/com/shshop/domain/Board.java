package com.shshop.domain;

import java.io.Serializable;

public class Board implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer boardId;
	private String boardName;

	public Board() {

	}

	public Board(String boardName) {
		this.setBoardName(boardName);
	}

	public Integer getBoardId() {
		return boardId;
	}

	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
}
