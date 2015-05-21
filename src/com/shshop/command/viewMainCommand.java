package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.system.AdminBean;

public class viewMainCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		AdminBean adminBean = new AdminBean(request); 
		
		HttpSession session = request.getSession();
		
		synchronized (session) {
			session.setAttribute(Constant.attrAdmin, adminBean);
		}
		
		return new CommandResult("/WEB-INF/view/main.jsp");
	}
}
