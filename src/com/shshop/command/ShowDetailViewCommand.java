package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.ProductDetail;
import com.shshop.service.ProductService;

public class ShowDetailViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		ProductService service = new ProductService();
		ProductDetail productDetail = service.getProductDetail(request);
		if (productDetail == null)
			return null;

		synchronized (request) {
			request.setAttribute(Constant.attrProductDetail, productDetail);
		}

		CommandResult commandResult = new CommandResult("/WEB-INF/view/detailView/detailView.jsp");

		return commandResult;
	}
}
