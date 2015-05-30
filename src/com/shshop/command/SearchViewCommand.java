package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class SearchViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute(Constant.attrKeywords, request.getParameter("keywords"));

		return new CommandResult("/WEB-INF/view/searchView/searchProducts.jsp");
	}
}
