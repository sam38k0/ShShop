package com.shshop.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shshop.control.CommandResult;
import com.shshop.domain.MainItemSetting;
import com.shshop.domain.Product;
import com.shshop.service.AuthenticatorService;
import com.shshop.service.ProductService;

public class MainViewCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		AuthenticatorService attService = new AuthenticatorService();
		ProductService productService = new ProductService();

		List<Product> productsCount = attService.getProductTypeCount();
		List<MainItemSetting> productsCList = new ArrayList<MainItemSetting>();
		Product productsC;
		for (int i = 0; i <productsCount.size(); i++) {
			productsC = productsCount.get(i);
			String imagePath = productService.getMainImagePath(productsC);
			
			MainItemSetting productsCSetting = new MainItemSetting(productsC, imagePath);
			productsCList.add(productsCSetting);
		}
		
		List<Product> productsDate = attService.getProductTypeDate();
		List<MainItemSetting> ProductsDList = new ArrayList<MainItemSetting>();
		Product productsD;
		for (int j = 0; j < productsDate.size(); j++) {
			productsD = productsDate.get(j);
			String imagePath = productService.getMainImagePath(productsD);
			
			MainItemSetting productsDSetting = new MainItemSetting(productsD, imagePath);
			ProductsDList.add(productsDSetting);
		}
		
		request.setAttribute("productsC", productsCList);
		request.setAttribute("productsD", ProductsDList);

		return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}
}