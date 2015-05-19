package com.shshop.control;

import com.shshop.command.Command;
import com.shshop.command.InsertProductCommand;
import com.shshop.command.InsertProductViewCommand;
import com.shshop.command.JoinCommand;
import com.shshop.command.LoginCommand;
import com.shshop.command.LogoutCommand;
import com.shshop.command.viewMainCommand;

public class CommandFactory {
	public static Command createCommand(String pathInfo) {
		switch (pathInfo) {
		case "/login":
			return new LoginCommand();
		case "/logout":
			return new LogoutCommand();
		case "/join":
			return new JoinCommand();
		case "/insertProduct":
			return new InsertProductCommand();
		case "/insertProductView":
			return new InsertProductViewCommand();
		case "/search":
			return null;
		case "/viewMain":
			return new viewMainCommand();
		case "/insertHopeProductView":
			return null;
		case "/headerView":
			return null;
		default:
			return null;
		}
	}
}
