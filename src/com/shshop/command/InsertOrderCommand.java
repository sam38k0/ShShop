package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.OrderService;
import com.shshop.service.ProductService;

public class InsertOrderCommand implements Command{

	@Override
	public CommandResult execute(HttpServletRequest request,
			HttpServletResponse response) {
		CommandResult comm = null;
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute(Constant.attrUser);
		
		Integer userId = user.getUserId();
		Integer productId = Integer.parseInt(request.getParameter("productId"));
		Address address = null;
		String basicAdd = request.getParameter("basicAdd");
		String detailAdd = request.getParameter("detailAdd");
		
		ProductService proService = new ProductService(request, response);
		Product product;
		
		AuthenticatorService attService = new AuthenticatorService(request, response);
		
		if (basicAdd == null && detailAdd == null) {
			address = attService.getUserAdd(user.getUserId());
			if (address == null) {
				address = new Address(userId, "", "");
				attService.insertUserAdd(address);
				address = attService.getUserAdd(userId);
			}
		} else {
			address = new Address(userId, basicAdd, detailAdd);
			attService.insertUserAdd(address);
			address = attService.getUserAdd(userId);
		}
		
		Integer idAddress = address.getIdAddress();
		
		Order order = new Order(userId, productId, idAddress);
		
		OrderService orderService = new OrderService(request, response);
		orderService.insertOrderData(order);
		
		
		return null;
	}
	
}
