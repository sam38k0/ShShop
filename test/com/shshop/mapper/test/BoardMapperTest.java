package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Board;
import com.shshop.mapper.BoardMapper;
import com.shshop.util.MyBatisUtil;

public class BoardMapperTest {
	SqlSession sqlSession = null;
	BoardMapper boardMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		boardMapper = sqlSession.getMapper(BoardMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testInsertBoard() {
		int countBefore = boardMapper.getBoardCount();
		boardMapper.insertBoard(new Board("testBoard1"));
		boardMapper.insertBoard(new Board("testBoard2"));
		int countAfter = boardMapper.getBoardCount();
		assertTrue("testInsertBoard", countBefore + 2 == countAfter);
	}

	@Test
	public void testDeleteBoard() {
		boardMapper.insertBoard(new Board("testBoard1"));
		boardMapper.insertBoard(new Board("testBoard2"));
		boardMapper.insertBoard(new Board("testBoard3"));

		List<Board> boards = boardMapper.getAllBoard();
		for (int i = 0; i < boards.size(); i++)
			boardMapper.deleteBoard(boards.get(i).getBoardId());

		int count = boardMapper.getBoardCount();
		assertEquals("testDeleteBoard", count, 0);
	}

	@Test
	public void testUpdateBoard() {
		boardMapper.insertBoard(new Board("testBoard1"));
		List<Board> boards = boardMapper.getAllBoard();
		Board board = boards.get(0);
		Integer boardId = board.getBoardId();
		board.setBoardName("test");
		boardMapper.updateBoard(board);
		board = boardMapper.getBoardById(boardId);
		assertTrue("testUpdateBoard", board.getBoardName().equals("test"));
	}
}
