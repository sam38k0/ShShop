package com.shshop.command;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.service.AuthenticatorService;

public class LoginCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/plain");

		CommandResult commandResult = null;

		try {
			commandResult = new AuthenticatorService().doLoginProcess(request);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return commandResult;
	}
}