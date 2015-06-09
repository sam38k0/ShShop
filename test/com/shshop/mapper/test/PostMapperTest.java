package com.shshop.mapper.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.shshop.domain.Board;
import com.shshop.domain.Post;
import com.shshop.domain.PostProc;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.mapper.BoardMapper;
import com.shshop.mapper.PostMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

public class PostMapperTest {
	SqlSession sqlSession = null;
	PostMapper postMapper = null;
	BoardMapper boardMapper = null;
	UserMapper userMapper = null;
	ProductMapper productMapper = null;

	@Before
	public void setUp() throws Exception {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		postMapper = sqlSession.getMapper(PostMapper.class);
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		userMapper = sqlSession.getMapper(UserMapper.class);
		productMapper = sqlSession.getMapper(ProductMapper.class);
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
		postMapper.insertPost(new Post("comment", boards.get(0).getBoardId(), null, 1));
		postMapper.insertPost(new Post("comment", boards.get(0).getBoardId(), 1, 1));
		int countAfter = postMapper.getPostCount();
		assertTrue("testInsertPost", countBefore + 2 == countAfter);
	}

	@Test
	public void testUpdatePost() {
		boardMapper.insertBoard(new Board("testBoard2"));
		List<Board> boards = boardMapper.getAllBoard();
		boards.get(0).getBoardId();
		postMapper.insertPost(new Post("comment", boards.get(0).getBoardId(), null, 1));
		int i = 1;
		Post post = null;
		while (true) {
			post = postMapper.getPostById(i);
			if (post != null)
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

		postMapper.insertPost(new Post("comment", boards.get(0).getBoardId(), null, 1));
		int countBefore = postMapper.getPostCount();

		int i = 1;
		Post post = null;
		while (true) {
			post = postMapper.getPostById(i);
			if (post != null)
				break;
			i++;
		}
		postMapper.deletePost(post.getPostId());
		int countAfter = postMapper.getPostCount();
		assertEquals("testDeleteBoard", countBefore, countAfter + 1);
	}

	@Test
	public void testInsertProc() {

		boardMapper.insertBoard(new Board("testBoard"));
		userMapper.insertUserByEmail(new User("email", "password"));

		int i = 1;
		User user = null;
		while (true) {
			user = userMapper.getUserById(i);
			if (user != null)
				break;
			i++;
		}

		productMapper.insertProduct(new Product(user.getUserId(), "product", 60, 60, 1, 204, "tag", "desc", 30, false, false, true));
		i = 1;
		Product product = null;
		while (true) {
			product = productMapper.getProductById(i);
			if (product != null)
				break;
			i++;
		}

		i = 1;
		Board board = null;
		while (true) {
			board = boardMapper.getBoardById(i);
			if (board != null)
				break;
			i++;
		}

		int countBefore = postMapper.getPostCount();
		Post post = new Post("comment", board.getBoardId(), null, 0);
		PostProc postProc = new PostProc(post, user, product);
		postMapper.insertPostByProc(postProc);
		int countAfter = postMapper.getPostCount();

		assertEquals("testDeleteBoard", countBefore, countAfter - 1);
		assertTrue("testDeleteBoard", postProc.getInsertedPostId() > 0);
	}

	@Test
	public void testGetAllPostOfProdcut() {
		boardMapper.insertBoard(new Board("testBoard"));
		userMapper.insertUserByEmail(new User("email", "password"));

		int i = 1;
		User user = null;
		while (true) {
			user = userMapper.getUserById(i);
			if (user != null)
				break;
			i++;
		}

		productMapper.insertProduct(new Product(user.getUserId(), "product", 60, 60, 1, 204, "tag", "desc", 30, false, false, true));
		i = 1;
		Product product = null;
		while (true) {
			product = productMapper.getProductById(i);
			if (product != null)
				break;
			i++;
		}

		i = 1;
		Board board = null;
		while (true) {
			board = boardMapper.getBoardById(i);
			if (board != null)
				break;
			i++;
		}

		Post post = new Post("comment", board.getBoardId(), null, 0);
		PostProc postProc = new PostProc(post, user, product);
		postMapper.insertPostByProc(postProc);

		List<Post> posts = postMapper.getAllPostOfProdcut(product.getProductId());
		assertTrue("testGetAllPostOfProdcut1", postProc.getInsertedPostId() > 0);
		assertTrue("testGetAllPostOfProdcut2", posts.size() > 0);
	}

	@Test
	public void testGetUserOfPost() {
		boardMapper.insertBoard(new Board("testBoard"));
		userMapper.insertUserByEmail(new User("email", "password"));

		int i = 1;
		User user = null;
		while (true) {
			user = userMapper.getUserById(i);
			if (user != null)
				break;
			i++;
		}

		productMapper.insertProduct(new Product(user.getUserId(), "product", 60, 60, 1, 204, "tag", "desc", 30, false, false, true));
		i = 1;
		Product product = null;
		while (true) {
			product = productMapper.getProductById(i);
			if (product != null)
				break;
			i++;
		}

		i = 1;
		Board board = null;
		while (true) {
			board = boardMapper.getBoardById(i);
			if (board != null)
				break;
			i++;
		}

		Post post = new Post("comment", board.getBoardId(), null, 0);
		PostProc postProc = new PostProc(post, user, product);
		postMapper.insertPostByProc(postProc);
		List<Post> posts = postMapper.getAllPostOfProdcut(product.getProductId());
		assertTrue("testGetUserOfPost1", postProc.getInsertedPostId() > 0);
		assertTrue("testGetUserOfPost2", posts.size() > 0);
		
		for(Post postItem: posts) {
			List<User> userItem = postMapper.getUserOfPost(postItem.getPostId());
			assertTrue("testGetUserOfPost3", userItem.get(0) != null);
		}
			
	}
}
