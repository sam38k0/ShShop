package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;

public class InsertProductViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		CommandResult commandResult = new CommandResult("/WEB-INF/view/insertProduct.jsp");
		return commandResult;
	}

}
