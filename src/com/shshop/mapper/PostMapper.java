package com.shshop.mapper;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Post;

public interface PostMapper {
	public int getPostCount();
	
	public Post getPostById(@Param("postId") int postId); 
	
	//public void insertPost(PostProc postProc);
	
	public void insertPost(Post post);
	
	public void updatePost(Post post);
	
	public void deletePost(@Param("postId") int postId);
}
