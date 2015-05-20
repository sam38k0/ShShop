package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class InsertProductCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession(false);

		if (session == null && session.getAttribute(Constant.attrUser) == null)
			return null;

		CommandResult commandResult = new CommandResult("/WEB-INF/view/insertProduct.jsp");

		return commandResult;
	}
}
