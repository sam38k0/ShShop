package com.shshop.command;

import com.shshop.control.CommandResult;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutCommand implements Command {
	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		CommandResult commandResult = null;

		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		
		commandResult = new CommandResult("text/html","Success");

		return commandResult;
	}
}