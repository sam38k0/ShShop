package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Post;
import com.shshop.domain.PostProc;
import com.shshop.domain.User;

public interface PostMapper {
	public int getPostCount();
	
	public Post getPostById(@Param("postId") int postId); 
	
	public List<Post> getChildPosts(Post post);
	
	public int insertPostByProc(PostProc postProc);
	
	public void insertPost(Post post);
	
	public void updatePost(Post post);
	
	public void deletePost(@Param("postId") int postId);
	
	public List<Post> getAllPostOfProdcut(@Param("productId") int productId);
	
	public User getUserOfPost(@Param("postId") int postId);
}
