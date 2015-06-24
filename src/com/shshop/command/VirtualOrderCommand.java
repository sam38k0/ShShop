package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.service.OrderService;

public class VirtualOrderCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		OrderService orderService = new OrderService();
		return orderService.createVirtualOrder(request);
	}

}
