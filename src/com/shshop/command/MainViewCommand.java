package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;

public class MainViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {

		return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}
}
