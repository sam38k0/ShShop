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
import com.shshop.domain.Product;
import com.shshop.domain.ProductDetail;
import com.shshop.domain.ProductImage;
import com.shshop.domain.ProductProc;
import com.shshop.domain.User;
import com.shshop.helper.KeywordGuesser;
import com.shshop.helper.TimestampFileRenamePolicy;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.response.InsertProductParams;
import com.shshop.response.ProductSearchResult;
import com.shshop.response.ProductSearchResultParam;
import com.shshop.util.MyBatisUtil;

@SuppressWarnings("unused")
public class ProductService {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private SqlSession sqlSession = null;
	private MultipartRequest multi = null;

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
			if(user!=null)
				productInfo.setProductOwner(user);

			return productInfo;

		} finally {
			sqlSession.close();
		}
	}
	    
	public CommandResult searchProdcuts() {
		// [TODO]: 실제 데이터를 사용해야 한다.

		String keywords = request.getParameter(Constant.attrKeywords);
		String dataPage = request.getParameter(Constant.attrDataPage);
		String sortCondition = request.getParameter(Constant.attrSort);
		String priceFrom = request.getParameter(Constant.attrPriceFrom);
		String priceTo = request.getParameter(Constant.attrPriceTo);

		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		if (sortCondition == null || sortCondition.equals("")) {
			sortCondition = "1";
		}
		
		if(priceFrom == null || priceFrom.equals("")) {
			priceFrom = "0";
		}
		
		if(priceTo == null || priceTo.equals("")) {
			priceTo = "100000000";
		}

		HttpSession session = request.getSession();
		ProductSearchResult searchResult = (ProductSearchResult) session.getAttribute(Constant.attrSearchResult);

		if (keywords == null || keywords == "")
			return null;

		if (searchResult == null || !searchResult.getKeywords().equals(keywords)) {
 
			sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
			
			String filterdKeywords;
			try {
				filterdKeywords = KeywordGuesser.getKeywordsWithoutWhiteSpace( keywords,"|");
			} catch (IOException e) {
				return null;
			}
			
			List<ProductSearchResultParam> searchResults = new ArrayList<>();
			List<Product> results = productMapper.getSearchedProducts(filterdKeywords);
			for (int i = 0; i < results.size(); i++) {
				List<ProductImage> images = imageMapper.getProductImages(results.get(i).getProductId());
				if(images!=null)
					searchResults.add( new ProductSearchResultParam(results.get(i),images.get(0).getImagePath()));
				else
					searchResults.add( new ProductSearchResultParam(results.get(i),"C:/temp/noimg.png"));
			}

			searchResult = new ProductSearchResult(Integer.parseInt(dataPage), keywords, Integer.parseInt(sortCondition), searchResults);
			session.setAttribute(Constant.attrSearchResult, searchResult);

		} else {
			searchResult.setKeywords(keywords);
			searchResult.setCurrentPage(Integer.parseInt(dataPage));
			searchResult.setSortCondition(Integer.parseInt(sortCondition));
			searchResult.setPriceFrom(Integer.parseInt(priceFrom));
			searchResult.setPriceTo(Integer.parseInt(priceTo));
		}

		return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");
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
			if(i != newFileNames.size()-1) {
				uploadFileBulder.append(fileRelativePath + ",");
			} else {
				uploadFileBulder.append(fileRelativePath);
			}
		}
		
		return uploadFileBulder.toString();
	}

	private boolean insertProductByProc(User user) throws IOException {
		String uploadedFilePaths = uploadFilesAndGetFilePaths();
		if(uploadedFilePaths == null || uploadedFilePaths.equals("")) {
			return false;
		}
		
		InsertProductParams psParam = new InsertProductParams(multi);
		ProductProc productProc = new ProductProc(user.getUserId(),getCategoryId(),psParam.getProductName(), psParam.getPrice(), psParam.getStock(), psParam.getTransactionType(),
				psParam.getConnectionOpt(), psParam.getTags(), psParam.getDescription(), 0, false, true, false,uploadedFilePaths);
		
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
}