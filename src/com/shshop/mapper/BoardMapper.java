package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Board;

public interface BoardMapper {
	public int getBoardCount();

	public Board getBoardById(@Param("boardId") int boardId);

	public Board getBoardByName(@Param("boardName") String boardName);

	public List<Board> getAllBoard();

	public void insertBoard(Board board);

	public void updateBoard(Board board);

	public void deleteBoard(@Param("boardId") int boardId);
}
