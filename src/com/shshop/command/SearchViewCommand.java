package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class SearchViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		String keywords = (String) request.getParameter(Constant.attrKeywords);
		if (keywords == null)
			return null;
		
		request.setAttribute(Constant.attrKeywords, keywords);

		return new CommandResult("/WEB-INF/view/searchView/searchProducts.jsp");
	}
}
