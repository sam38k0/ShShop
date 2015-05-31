package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;

public class SearchViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		synchronized(session) {
			
			 String keywords = (String)request.getParameter(Constant.attrKeywords);
			 String dataPage = (String)request.getParameter(Constant.attrDataPage);
 
			 if(keywords == null)
				 return null;
			 
			 if(dataPage == null)
				 dataPage = "1";
			 
			 session.setAttribute(Constant.attrKeywords,keywords);
			 session.setAttribute(Constant.attrDataPage,dataPage);
		}
		
		return new CommandResult("/WEB-INF/view/searchView/searchProducts.jsp");
	}
}
