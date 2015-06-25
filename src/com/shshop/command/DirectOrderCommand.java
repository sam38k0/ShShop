package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.OrderState;
import com.shshop.service.OrderService;

public class DirectOrderCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		OrderService orderService = new OrderService();
		return orderService.createOrderByRequest(request, OrderState.Activated);
	}

}
