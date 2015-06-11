package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.service.PostCommentService;

public class CommentPostCommend implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		return new PostCommentService(request,response).addComment();
	}
}
