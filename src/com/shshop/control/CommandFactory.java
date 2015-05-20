package com.shshop.control;

import com.shshop.command.CheckLoginStateCommand;
import com.shshop.command.Command;
import com.shshop.command.InsertProductCommand;
import com.shshop.command.JoinCommand;
import com.shshop.command.LoginCommand;
import com.shshop.command.LogoutCommand;
import com.shshop.command.viewMainCommand;
import com.shshop.constant.Constant;

public class CommandFactory {
	public static Command createCommand(String pathInfo) {
		switch (pathInfo) {
		case Constant.login:
			return new LoginCommand();
		case Constant.logout:
			return new LogoutCommand();
		case Constant.checklogin:
			return new CheckLoginStateCommand();
		case Constant.join:
			return new JoinCommand();
		case Constant.insertProduct:
			return new InsertProductCommand(); 
		case Constant.search:
			return null;
		case Constant.viewMain:
			return new viewMainCommand();
		case Constant.insertHopeProductView:
			return null;
		default:
			return null;
		}
	}
}
