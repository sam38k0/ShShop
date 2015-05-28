package com.shshop.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.command.Command;
import com.shshop.constant.Constant;
import com.shshop.service.CategoryControlService;
import com.shshop.system.AdminBean;
import com.shshop.threading.AleadyClosedException;
import com.shshop.threading.ThreadPool;

public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 2335728773164645554L;

	public Command getCommand(HttpServletRequest request) {
		RequestHelper helper = new RequestHelper(request);
		Command command = helper.getCommand();
		return command;
	}

	public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		setAdminBean(request);

		CommandResult result = null;
		Command command = getCommand(request);
		if (command != null)
			result = command.execute(request, response);
		else
			result = new CommandResult("/WEB-INF/view/error.jsp");

		if (result.getViewURI() != null) {
			dispatch(request, response, result.getViewURI());
		} else {
			sendContent(request, response, result);
		}
	}

	public void sendContent(HttpServletRequest request, HttpServletResponse response, CommandResult commandResult) {
		response.setContentType(commandResult.getContentType());

		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(commandResult.getContent());
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			out.close();
		}
	}

	public void dispatch(HttpServletRequest request, HttpServletResponse response, String viewURI) throws ServletException, IOException {
		RequestDispatcher rd = getServletContext().getRequestDispatcher(viewURI);
		rd.forward(request, response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		processRequest(request, response);
	}
 

	private void setAdminBean(HttpServletRequest request) {
		AdminBean adminBean = new AdminBean(request);

		HttpSession session = request.getSession();

		synchronized (session) {
			session.setAttribute(Constant.attrAdmin, adminBean);
		}
	}
}
