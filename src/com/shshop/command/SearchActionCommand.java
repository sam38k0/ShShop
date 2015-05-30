package com.shshop.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.service.ProductService;

public class SearchActionCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		ProductService psService = new ProductService(request, response);
		return psService.setSearchedProductDatas();
	}
}
