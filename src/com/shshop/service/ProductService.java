package com.shshop.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.oreilly.servlet.MultipartRequest;
import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Category;
import com.shshop.domain.Post;
import com.shshop.domain.Product;
import com.shshop.domain.ProductDetail;
import com.shshop.domain.ProductImage;
import com.shshop.domain.ProductProc;
import com.shshop.domain.User;
import com.shshop.helper.KeywordGuesser;
import com.shshop.helper.PostHtmlBuilder;
import com.shshop.helper.TimestampFileRenamePolicy;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.PostMapper;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.response.InsertProductParams;
import com.shshop.response.OrderInfo;
import com.shshop.response.ProductSearchResult;
import com.shshop.response.ProductSearchResultManager;
import com.shshop.response.ProductSearchResultParam;
import com.shshop.util.MyBatisUtil;

@SuppressWarnings("unused")
public class ProductService {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private SqlSession sqlSession = null;
	private MultipartRequest multi = null;
	private ProductSearchResultManager searchResultManager = null;

	public ProductService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public CommandResult insertProduct() throws IOException, ServletException {

		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			if (insertProductByProc(user) != true) {
				sqlSession.rollback();
				return new CommandResult(Constant.textPlain, Constant.productInsertionError);
			}
		} finally {
			sqlSession.commit();
			sqlSession.close();
		}

		return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}

	public ProductDetail getProductInformation(Integer productId) {

		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			Product product = productMapper.getProductById(productId);
			if (product == null)
				return null;

			ProductDetail productInfo = new ProductDetail();
			productInfo.setProduct(product);

			ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
			List<ProductImage> images = imageMapper.getProductImages(productId);

			String contextPath = request.getContextPath();

			if (images != null) {
				for (int i = 0; i < images.size(); i++) {
					productInfo.addImagePath(contextPath + images.get(i).getImagePath());
				}
			}

			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			User user = userMapper.getUserById(product.getUserId());
			if (user != null)
				productInfo.setProductOwner(user);
			
			PostMapper postMapper = sqlSession.getMapper(PostMapper.class);
			List<Post> posts = postMapper.getAllPostOfProdcut(productId);
			String postResults = PostHtmlBuilder.getPostHtml(posts, postMapper);
			if(postResults != null && !postResults.equals("")) {
				System.out.println(postResults);
				productInfo.setPostResults(postResults);
			}

			return productInfo;

		} finally {
			sqlSession.close();
		}
	}
	
	public OrderInfo createNewOrderInfo(Integer productId, int quantity, int shippingPrice) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			Product product = getProductById(sqlSession, productId);
			String imagePath = getProductFirstImagePaths(sqlSession,productId);
			
			if(product == null)
				return null;
			
			if(imagePath == "") {
				//[TODO] : Set Default Image
			}
			
			return new OrderInfo(product, imagePath, quantity, shippingPrice);
			
		} finally {
			sqlSession.close();
		}
	}
	
	private String getProductFirstImagePaths(SqlSession sqlSession, Integer productId) {
		ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
		List<ProductImage> images = imageMapper.getProductImages(productId);

		String contextPath = request.getContextPath();

		if (images != null) {
			return images.get(0).getImagePath();
		}
		
		return "";
	}
	
	private Product getProductById(SqlSession sqlSession, int productId) {
		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		Product product = productMapper.getProductById(productId);
		return product;
	}

	public CommandResult searchProdcuts() {
		String categoryName = request.getParameter(Constant.attrCategoryName);
		if (categoryName != null && categoryName != "") {
			return searchCategory(categoryName);
		}

		String keywords = request.getParameter(Constant.attrKeywords);
		String filterdKeywords = getFilterdKeyword(keywords);
		if (filterdKeywords == null || filterdKeywords == "") {
			return null;
		}

		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		String sortCondition = request.getParameter(Constant.attrSort);
		if (sortCondition == null || sortCondition.equals("")) {
			sortCondition = "1";
		}

		String priceFrom = request.getParameter(Constant.attrPriceFrom);
		if (priceFrom == null || priceFrom.equals("")) {
			priceFrom = "0";
		}

		String priceTo = request.getParameter(Constant.attrPriceTo);
		if (priceTo == null || priceTo.equals("")) {
			priceTo = "100000000";
		}

		ProductSearchResult searchResult = getSearchResult(filterdKeywords);

		if (searchResult == null) {
			List<ProductSearchResultParam> searchResults = querySearchData(filterdKeywords);
			searchResult = new ProductSearchResult(Integer.parseInt(dataPage), keywords, Integer.parseInt(sortCondition), 10, searchResults);
			searchResultManager.addSearchResult(filterdKeywords, searchResult);
		} else {
			searchResult.setKeywords(keywords);
			searchResult.setPageDivNum(10);
			searchResult.setCurrentPage(Integer.parseInt(dataPage));
			searchResult.setSortCondition(Integer.parseInt(sortCondition));
			searchResult.setPriceFrom(Integer.parseInt(priceFrom));
			searchResult.setPriceTo(Integer.parseInt(priceTo));
		}

		request.setAttribute(Constant.attrSearchResult, searchResult);

		return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");
	}

	public CommandResult searchCategoryOfProduct() {
		String strProductId = request.getParameter(Constant.attrProductId);
		if (strProductId == null || strProductId == "")
			return null;
		
		Integer productId = Integer.parseInt(strProductId);
		
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			
			Product product = productMapper.getProductById(productId);
			if(product == null)
				return null;
			
			List<Category> categories = productMapper.getProdcutCategories(Integer.parseInt(strProductId));
			if (categories == null)
				return null;
			
			String categoryName = categories.get(0).getName();
			
			String dataPage = request.getParameter(Constant.attrDataPage);
			if (dataPage == null || dataPage.equals("")) {
				dataPage = "1";
			}

			String sortCondition = request.getParameter(Constant.attrSort);
			if (sortCondition == null || sortCondition.equals("")) {
				sortCondition = "1";
			}

			String priceFrom = request.getParameter(Constant.attrPriceFrom);
			if (priceFrom == null || priceFrom.equals("")) {
				priceFrom = "0";
			}

			String priceTo = "" + (product.getPrice() + 1000000);

			ProductSearchResult searchResult = getSearchResult(categoryName);
			
			if (searchResult == null) {
				List<ProductSearchResultParam> searchResults = queryCategoryData(categoryName);
				searchResult = new ProductSearchResult(Integer.parseInt(dataPage), "", Integer.parseInt(sortCondition), 8, searchResults);
				searchResultManager.addSearchResult(categoryName, searchResult);
			} else {
				searchResult.setKeywords("");
				searchResult.setPageDivNum(8);
				searchResult.setCurrentPage(Integer.parseInt(dataPage));
				searchResult.setSortCondition(Integer.parseInt(sortCondition));
				searchResult.setPriceFrom(Integer.parseInt(priceFrom));
				searchResult.setPriceTo(Integer.parseInt(priceTo));
			}

			request.setAttribute(Constant.attrSearchResult, searchResult);

			return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");

		} finally {
			sqlSession.close();
		}
	}

	public CommandResult searchCategory(String categoryName) {

		String dataPage = request.getParameter(Constant.attrDataPage);
		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		String sortCondition = request.getParameter(Constant.attrSort);
		if (sortCondition == null || sortCondition.equals("")) {
			sortCondition = "1";
		}

		String priceFrom = request.getParameter(Constant.attrPriceFrom);
		if (priceFrom == null || priceFrom.equals("")) {
			priceFrom = "0";
		}

		String priceTo = request.getParameter(Constant.attrPriceTo);
		if (priceTo == null || priceTo.equals("")) {
			priceTo = "100000000";
		}

		ProductSearchResult searchResult = getSearchResult(categoryName);

		if (searchResult == null) {
			List<ProductSearchResultParam> searchResults = queryCategoryData(categoryName);
			searchResult = new ProductSearchResult(Integer.parseInt(dataPage), "", Integer.parseInt(sortCondition), 10, searchResults);
			searchResultManager.addSearchResult(categoryName, searchResult);
		} else {
			searchResult.setKeywords("");
			searchResult.setPageDivNum(10);
			searchResult.setCurrentPage(Integer.parseInt(dataPage));
			searchResult.setSortCondition(Integer.parseInt(sortCondition));
			searchResult.setPriceFrom(Integer.parseInt(priceFrom));
			searchResult.setPriceTo(Integer.parseInt(priceTo));
		}

		request.setAttribute(Constant.attrSearchResult, searchResult);

		return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");
	}

	private List<ProductSearchResultParam> querySearchData(String filterdKeywords) {
		List<ProductSearchResultParam> searchResults = null;

		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

		List<Product> results = productMapper.getSearchedProducts(filterdKeywords);
		if (results != null)
			searchResults = new ArrayList<>();

		for (int i = 0; i < results.size(); i++) {
			User user = userMapper.getUserById(results.get(i).getUserId());
			List<ProductImage> images = imageMapper.getProductImages(results.get(i).getProductId());
			if (images != null) {
				searchResults.add(new ProductSearchResultParam(user, results.get(i), images.get(0).getImagePath()));
			} else {
				searchResults.add(new ProductSearchResultParam(user, results.get(i), "C:/temp/noimg.png"));
			}
		}

		return searchResults;
	}

	private List<ProductSearchResultParam> queryCategoryData(String categoryName) {
		List<ProductSearchResultParam> searchResults = null;

		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		CategoryMapper categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

		List<Product> results = categoryMapper.getCategoryProducts(categoryName);
		if (results != null)
			searchResults = new ArrayList<>();

		for (int i = 0; i < results.size(); i++) {
			User user = userMapper.getUserById(results.get(i).getUserId());
			List<ProductImage> images = imageMapper.getProductImages(results.get(i).getProductId());
			if (images != null) {
				searchResults.add(new ProductSearchResultParam(user, results.get(i), images.get(0).getImagePath()));
			} else {
				searchResults.add(new ProductSearchResultParam(user, results.get(i), "C:/temp/noimg.png"));
			}
		}

		return searchResults;
	}

	private ProductSearchResult getSearchResult(String keywords) {
		HttpSession session = request.getSession();

		searchResultManager = (ProductSearchResultManager) session.getAttribute(Constant.attrSearchResultMap);

		ProductSearchResult searchResult = null;
		if (searchResultManager != null) {
			searchResult = searchResultManager.getSearchResult(keywords);
		} else {
			searchResultManager = new ProductSearchResultManager();
			session.setAttribute(Constant.attrSearchResultMap, searchResultManager);
		}

		return searchResult;
	}

	private String getFilterdKeyword(String keywords) {
		if (keywords == null || keywords == "")
			return null;

		String filterdKeywords = "";
		try {
			filterdKeywords = KeywordGuesser.getKeywordsWithoutWhiteSpace(keywords, "|");
		} catch (IOException e) {
			return null;
		}

		return filterdKeywords;
	}

	private String uploadFilesAndGetFilePaths() throws IOException {
		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUploadAbsolutePath);

		TimestampFileRenamePolicy fileRenamePolicy = new TimestampFileRenamePolicy();
		if (getMulti() == null)
			setMulti(new MultipartRequest(request, filePath, 500 * 1024, "UTF-8", fileRenamePolicy));

		StringBuilder uploadFileBulder = new StringBuilder();
		List<String> newFileNames = fileRenamePolicy.getNewFileNames();
		for (int i = 0; i < newFileNames.size(); i++) {
			String fileRelativePath = "";
			String fileUploadPath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
			fileRelativePath = fileUploadPath + newFileNames.get(i);
			if (i != newFileNames.size() - 1) {
				uploadFileBulder.append(fileRelativePath + ",");
			} else {
				uploadFileBulder.append(fileRelativePath);
			}
		}

		return uploadFileBulder.toString();
	}

	private boolean insertProductByProc(User user) throws IOException {
		String uploadedFilePaths = uploadFilesAndGetFilePaths();
		if (uploadedFilePaths == null || uploadedFilePaths.equals("")) {
			return false;
		}

		InsertProductParams psParam = new InsertProductParams(multi);
		ProductProc productProc = new ProductProc(user.getUserId(), getCategoryId(), psParam.getProductName(), psParam.getPrice(),
				psParam.getStock(), psParam.getTransactionType(), psParam.getConnectionOpt(), psParam.getTags(), psParam.getDescription(), 0, false,
				true, false, uploadedFilePaths);

		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		productMapper.insertProductProc(productProc);

		return true;
	}

	private Integer getCategoryId() throws IOException {
		String categoryName = multi.getParameter("miniCategory");

		if (categoryName == "" || categoryName == null)
			return null;

		String[] categorySplited = categoryName.split(">");

		String categoryLastName = categorySplited[categorySplited.length - 1].trim();

		CategoryMapper categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		Category category = categoryMapper.getCategoryByName(categoryLastName);
		if (category == null)
			return null;

		return category.getCategoryId();
	}

	private MultipartRequest getMulti() {
		return multi;
	}

	public void setMulti(MultipartRequest multi) {
		this.multi = multi;
	}
	
	public ProductImage getProductImg(int productId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		List<ProductImage> product;
		ProductImage productImg = null;
		try {
			ProductImageMapper productImgMapper = sqlSession.getMapper(ProductImageMapper.class);
			product = productImgMapper.getProductImages(productId);
			productImg = product.get(0);
		} finally {
			sqlSession.close();
		}
		return productImg;
	}
}