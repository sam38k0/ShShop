package com.shshop.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Board;
import com.shshop.domain.Post;
import com.shshop.domain.PostProc;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.helper.PostHtmlBuilder;
import com.shshop.mapper.BoardMapper;
import com.shshop.mapper.PostMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.util.MyBatisUtil;

public class PostCommentService {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private SqlSession sqlSession = null;

	public PostCommentService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	public CommandResult addComment() {
 
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		try {
			HttpSession session = request.getSession(false);
			User user = (User) session.getAttribute(Constant.attrUser);
			if (user == null) {
				return new CommandResult(Constant.textPlain, Constant.noUser);
			}
			
			String strProductId = request.getParameter(Constant.attrProductId);
			if (strProductId == null || strProductId == "") {
				return new CommandResult(Constant.textPlain, Constant.noProduct);
			}
			
			String comment = request.getParameter(Constant.attrComment);
			if (comment == null || comment == "") {
				return new CommandResult(Constant.textPlain, Constant.noComment);
			}
			
			Integer productId = Integer.parseInt(strProductId);
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			Product product = productMapper.getProductById(productId);
			BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
			Board board = boardMapper.getBoardByName(Constant.askAndReplyBoard);
			Post post = new Post(comment,board.getBoardId(),null, 0);
			
			PostMapper postMapper = sqlSession.getMapper(PostMapper.class);
			postMapper.insertPostByProc(new PostProc(post,user,product));
			
//			List<Post> posts = new ArrayList<>();
//			posts.add(post);
//			String postResults = PostHtmlBuilder.getPostHtml(posts, postMapper);
//			if(postResults != null && !postResults.equals("")) {
//				System.out.println("%%%%" + postResults);
//			}
			
			List<Post> posts = postMapper.getAllPostOfProdcut(productId);
			String postResults = PostHtmlBuilder.getPostHtml(posts, postMapper);
			if(postResults != null && !postResults.equals("")) {
				return new CommandResult(Constant.textPlain, postResults);
			}
			
		} finally {
			sqlSession.commit();
			sqlSession.close();
		}
		
		return null;
	}
}
