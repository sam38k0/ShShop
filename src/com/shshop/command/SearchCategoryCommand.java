package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class SearchCategoryCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String categoryName = (String) request.getParameter(Constant.attrCategoryName);
		if (categoryName == null)
			return null;

		request.setAttribute(Constant.attrCategoryName, categoryName);

		return new CommandResult("/WEB-INF/view/searchView/searchProducts.jsp");
	}

}
