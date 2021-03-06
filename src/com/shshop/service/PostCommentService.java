package com.shshop.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
	private SqlSession sqlSession = null;

	public PostCommentService() {
	}

	public CommandResult addComment(HttpServletRequest request) {

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

			Integer parentId = null;
			String strParentId = request.getParameter(Constant.attrParentId);
			if (strParentId != null && strParentId != "") {
				parentId = Integer.parseInt(strParentId.replace("postId_", ""));
			}

			Integer productId = Integer.parseInt(strProductId);
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			Product product = productMapper.getProductById(productId);
			BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
			Board board = boardMapper.getBoardByName(Constant.askAndReplyBoard);
			Post post = new Post(comment, board.getBoardId(), parentId, 0);

			PostMapper postMapper = sqlSession.getMapper(PostMapper.class);
			postMapper.insertPostByProc(new PostProc(post, user, product));

			List<Post> posts = postMapper.getAllPostOfProdcut(productId);
			String postResults = PostHtmlBuilder.getPostHtml(posts, postMapper);
			if (postResults != null && !postResults.equals("")) {
				return new CommandResult(Constant.textPlain, postResults);
			}

		} finally {
			sqlSession.commit();
			sqlSession.close();
		}

		return null;
	}
}
