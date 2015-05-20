package com.shshop.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class CheckLoginStateCommand  implements Command{
	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) { 
		
		HttpSession session = request.getSession(false);
		
		if( session != null && session.getAttribute( Constant.attrUser) != null)
			return new CommandResult(Constant.textHtml,Constant.onLogin);
		
		return new CommandResult(Constant.textHtml,Constant.Failed);
	}
}
