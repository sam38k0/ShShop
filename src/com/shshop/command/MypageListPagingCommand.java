package com.shshop.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.response.MyProductsInfo;
import com.shshop.service.ProductService;

public class MypageListPagingCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {

		// HttpSession session = request.getSession();
		// String buyOrderKey = request.getParameter(Constant.attrBuyOrderKey);
		// String sellOrderKey =
		// request.getParameter(Constant.attrSellOrderKey);
		// String myBoardKey = request.getParameter(Constant.attrMyBoardKey);
		// String dataPageInBuy =
		// request.getParameter(Constant.attrDataPageInBuy);
		// String dataPageInSell =
		// request.getParameter(Constant.attrDataPageInSell);
		// String dataPageInBoard =
		// request.getParameter(Constant.attrDataPageInBoard);

		/*
		 * if (buyOrderKey != null) { if (dataPageInBuy == null ||
		 * dataPageInBuy.equals("")) { dataPageInBuy = "1"; }
		 * OrderInfomationList buyOrderInfoList = (OrderInfomationList)
		 * session.getAttribute(buyOrderKey);
		 * buyOrderInfoList.setCurrentPage(Integer.parseInt(dataPageInBuy));
		 * List<OrderInformation> buyerCurrentPageInfos =
		 * buyOrderInfoList.getCurrentPageOrderInfos();
		 * request.setAttribute(Constant.attrBuyOrderInfoList,
		 * buyOrderInfoList); request.setAttribute(Constant.attrDataPageInBuy,
		 * dataPageInBuy);
		 * request.setAttribute(Constant.attrCurrentPagesResultBuying,
		 * buyerCurrentPageInfos); }
		 * 
		 * if (sellOrderKey != null) { if (dataPageInSell == null ||
		 * dataPageInSell.equals("")) { dataPageInSell = "1"; }
		 * 
		 * OrderInfomationList sellOrderInfoList = (OrderInfomationList)
		 * session.getAttribute(sellOrderKey);
		 * sellOrderInfoList.setCurrentPage(Integer.parseInt(dataPageInSell));
		 * List<OrderInformation> sellerCurrentPageInfos =
		 * sellOrderInfoList.getCurrentPageOrderInfos();
		 * request.setAttribute(Constant.attrSellOrderInfoList,
		 * sellOrderInfoList); request.setAttribute(Constant.attrDataPageInSell,
		 * dataPageInSell);
		 * request.setAttribute(Constant.attrCurrentPagesResultSelling,
		 * sellerCurrentPageInfos); }
		 * 
		 * if (myBoardKey != null) { if (dataPageInBoard == null ||
		 * dataPageInBoard.equals("")) { dataPageInBoard = "1"; }
		 * 
		 * MypageByBoardList mypageBoardList = (MypageByBoardList)
		 * session.getAttribute(myBoardKey);
		 * mypageBoardList.setCurrentPage(Integer.parseInt(dataPageInBoard));
		 * List<Product> myBoardListInfos =
		 * mypageBoardList.getCurrentPageOrderInfos();
		 * request.setAttribute(Constant.attrMyProductsList, mypageBoardList);
		 * request.setAttribute(Constant.attrDataPageInBoard, dataPageInBoard);
		 * request.setAttribute(Constant.attrCurrentPagesResultBoard,
		 * myBoardListInfos); }
		 */

		// 내 아이템 리스트
		//
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		String pageFilter = request.getParameter(Constant.attrDataPageFilter);
		if (pageFilter == null || pageFilter.equals("")) {
			pageFilter = "0";
		}

		String myProductsKey = "myProductInfoKey_" + user.getUserId().toString();

		ProductService productService = new ProductService();
		
		MyProductsInfo myProductsInfo = (MyProductsInfo) session.getAttribute(myProductsKey);
		if (myProductsInfo == null) {
			List<Product> products = productService.getProductsById(user.getUserId());
			if (products != null) {
				myProductsInfo = new MyProductsInfo(products, 1, 5);
				synchronized (session) {
					session.setAttribute(myProductsKey, myProductsInfo);
				}
			}
		}

		// Filtering
		List<Product> filteredProduct = new ArrayList<>();
		if (pageFilter.equals("1")) {
			List<Product> products = productService.getProductsById(user.getUserId());
			for (Product product : products) {
				if (product.getStock() > 0) {
					filteredProduct.add(product);
				}
			}
			myProductsInfo.setProducts(filteredProduct,1,5);

		} else if (pageFilter.equals("2")) {
			List<Product> products = productService.getProductsById(user.getUserId());
			for (Product product : products) {
				if (product.getStock() == 0) {
					filteredProduct.add(product);
				}
			}
			myProductsInfo.setProducts(filteredProduct,1,5);
		}

		myProductsInfo.setCurrentPage(Integer.parseInt(dataPage));

		request.setAttribute(Constant.attrMyProductsInfo, myProductsInfo);

		return new CommandResult("/WEB-INF/view/mypage/myProductsJsonData.jsp");
	}
}
