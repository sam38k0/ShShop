package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Board;
import com.shshop.domain.Post;
import com.shshop.mapper.BoardMapper;
import com.shshop.mapper.PostMapper;
import com.shshop.util.MyBatisUtil;

public class PostMapperTest {
	SqlSession sqlSession = null;
	PostMapper postMapper = null;
	BoardMapper boardMapper = null;
	
	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		postMapper = sqlSession.getMapper(PostMapper.class);
		boardMapper = sqlSession.getMapper(BoardMapper.class);
	}

	@After
	public void tearDown() throws Exception {
		sqlSession.rollback();
		sqlSession.close();
	}

	@Test
	public void testInsertPost() {
		int countBefore = postMapper.getPostCount();
		boardMapper.insertBoard(new Board("testBoard2"));
		List<Board> boards = boardMapper.getAllBoard();
		boards.get(0).getBoardId();
		postMapper.insertPost(new Post("comment",boards.get(0).getBoardId(),null,1));
		postMapper.insertPost(new Post("comment",boards.get(0).getBoardId(),1,1));
		int countAfter = postMapper.getPostCount();
		assertTrue("testInsertPost", countBefore + 2 == countAfter);
	}

	@Test
	public void testUpdatePost() {
		boardMapper.insertBoard(new Board("testBoard2"));
		List<Board> boards = boardMapper.getAllBoard();
		boards.get(0).getBoardId();
		postMapper.insertPost(new Post("comment",boards.get(0).getBoardId(),null,1)); 
		int i = 1;
		Post post = null;
		while(true) {
			post = postMapper.getPostById(i);
			if(post!=null)
				break;
			i++;
		}
		
		post.setComment("newComment");
		postMapper.updatePost(post); 
		post = postMapper.getPostById(post.getPostId());
		assertTrue("testUpdateBoard", post.getComment().equals("newComment"));
	}

	@Test
	public void testDeletePost() { 
		
		boardMapper.insertBoard(new Board("testBoard2"));
		List<Board> boards = boardMapper.getAllBoard();
		boards.get(0).getBoardId();
		
		postMapper.insertPost(new Post("comment",boards.get(0).getBoardId(),null,1)); 
		int countBefore = postMapper.getPostCount();
		
		int i = 1;
		Post post = null;
		while(true) {
			post = postMapper.getPostById(i);
			if(post!=null)
				break;
			i++;
		}
		postMapper.deletePost(post.getPostId());
		int countAfter = postMapper.getPostCount(); 
		assertEquals("testDeleteBoard", countBefore, countAfter + 1);
	}

}
