package com.shshop.constant;

public class Constant {
	// Command
	public static final String login = "/login";
	public static final String logout = "/logout";
	public static final String join = "/join";
	public static final String insertProductView = "/insertProductView";
	public static final String insertProduct = "/insertProduct";
	public static final String searchView = "/searchView";
	public static final String searchAction = "/searchAction";
	public static final String searchCategory = "/searchCategory";
	public static final String search = "/search";
	public static final String viewMain = "/viewMain";
	public static final String insertHopeProductView = "/insertHopeProduct";
	public static final String headerView = "/headerView";
	public static final String checklogin = "/checklogin";
	public static final String showDetailView = "/showDetailView";
	public static final String mypage = "/mypage";
	public static final String userUpdate = "/userUpdate";
	public static final String similarItemAction = "/similarItemAction";
	public static final String commentPostAction = "/commentPostAction";
	public static final String showOrderView = "/showOrderView";
	public static final String changeOrderAddr = "/changeOrderAddr";
	public static final String deleteOrderAddr = "/deleteOrderAddr";
	public static final String addAddress = "/addAddress";
	public static final String showShoppingCartView = "/showShoppingCartView";
	public static final String changeOrderItemCount = "/changeOrderItemCount";
	public static final String deleteOrder = "/deleteOrder";
	public static final String setShoppingCartPage = "/setShoppingCartPage";
	public static final String changeOrderItemChecked = "/changeOrderItemChecked";
	public static final String virtualOrder = "/virtualOrder";
	public static final String setMypageListPaging = "/setMypageListPaging";
	public static final String serOrderPage = "/orderPage";
	public static final String showOrderCompletedView = "/showOrderCompletedView";
	public static final String deleteOrderInfo = "/deleteOrderInfo";
	public static final String directOrder = "/directOrder";
	public static final String showDirectOrderView = "/showDirectOrderView";
	
	// Attribute
	public static final String attrUser = "user";
	public static final String attrEmail = "email";
	public static final String attrPassword = "password";
	public static final String attrAdmin = "adminBean";
	public static final String attrProductDetail = "productDetail";
	public static final String attrSearchResult = "searchResult";
	public static final String attrSearchResultMap = "searchResultMap";
	public static final String attrKeywords = "keywords";
	public static final String attrCategoryName = "categoryName";
	public static final String attrDataPage = "data-page";
	public static final String attrDataPageDivNum = "data-page-divnum";
	public static final String attrSort = "sort";
	public static final String attrPriceFrom = "price_from";
	public static final String attrPriceTo = "price_to";
	public static final String attrProductId = "productId";
	public static final String attrComment = "comment";
	public static final String attrParentId = "parentId";
	public static final String attrOrderViewInfo = "orderViewInfo";
	public static final String attrOrderViewInfoCompleted = "orderViewInfoCompleted";
	public static final String attrOrderKey = "orderKey";
	public static final String attrAddressIndex = "addressIndex";
	public static final String attrUserName = "userName";
	public static final String attrSelectedAddressResult = "selectedAddressResult";
	public static final String attrAddrName = "addrName";
	public static final String attrAddrZipCodeHead = "addrZipCodeHead";
	public static final String attrAddrZipCodeTail = "addrZipCodeTail";
	public static final String attrAddrBasicNew = "addrBasicNew";
	public static final String attrAddrBasicOld = "addrBasicOld";
	public static final String attrAddrDetail = "addrDetail";
	public static final String attrAddrPhoneNumber = "addrPhoneNumber";
	public static final String attrOrderIndex = "orderIndex";
	public static final String attrItemNewQuantity = "itemNewQuantity";
	public static final String attrTotalPrice = "totalPrice";
	public static final String attrCurrentPagesResult = "currentPageResults";
	public static final String attrTotalPageCount = "totalPageCount";
	public static final String attrUncheckedIndx = "uncheckedIndx";
	public static final String attrCheckedIndex = "checkedIndex";
	public static final String attrVirtualOrderCount = "virtualOrderCount";
	public static final String attrOrderCount = "orderCount";
	public static final String attrBuyOrderInfoList = "buyOrderInfoList";
	public static final String attrBuyOrderKey = "buyOrderKey";
	public static final String attrSellOrderInfoList = "sellOrderInfoList";
	public static final String attrSellOrderKey = "sellOrderKey";
	public static final String attrCurrentPagesResultBuying = "currentPageResultsBuying";
	public static final String attrCurrentPagesResultSelling = "currentPageResultsSelling";
	public static final String attrCurrentPagesResultBoard = "currentPagesResultBoard";
	public static final String attrLoginResult = "loginResult";
	public static final String attrMyProductsList = "myProductsList";
	public static final String attrMyBoardKey = "myBoardKey";
	public static final String attrDataPageInBuy = "dataPageInBuy";
	public static final String attrDataPageInSell = "dataPageInSell";
	public static final String attrDataPageInBoard = "dataPageInBoard";
	
	// DD Parameter
	public static final String paramFileUpload = "file-upload";
	public static final String paramFileUploadAbsolutePath = "file-upload-absolute";
	public static final String paramFileUploadRepository = "file-upload-repository";

	// ContentType
	public static final String textHtml = "text/html;charset=UTF-8";
	public static final String textPlain = "text/plain;charset=UTF-8";

	// Message
	public static final String wrongEmail = "Please, check email information.";
	public static final String noPassword = "Please, put a password.";
	public static final String noUser = "There is no user information.";
	public static final String productInsertionError = "Product Insertion Error Occured.";
	public static final String noProduct = "There is no product information.";
	public static final String noComment = "There is no comment information.";
	public static final String noAddress = "There is no user address information";
	public static final String overAddrlimitInput = "This input exceeded the size that can be input.( Maximum 5 )";

	// Ajax Response
	public static final String Success = "Success";
	public static final String Failed = "Failed";
	public static final String onLogin = "onLogin";

	// Path
	public static final String contextPath = "/ShShop/WebContent";

	// DB Constant 
	public static final String askAndReplyBoard = "askAndReply";
}
