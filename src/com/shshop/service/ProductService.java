package com.shshop.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
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
import com.shshop.domain.ProductCategory;
import com.shshop.domain.ProductDetail;
import com.shshop.domain.ProductImage;
import com.shshop.domain.User;
import com.shshop.helper.TimestampFileRenamePolicy;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.ProductCategoryMapper;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.response.InsertProductParams;
import com.shshop.response.SearchResult;
import com.shshop.response.SearchResultParam;
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
		if (user == null)
			return new CommandResult(Constant.textPlain, Constant.noUser);

		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			List<String> uploadedFilePaths = uploadFiles();

			Product product = insertProduct(user);
			if (product == null) {
				sqlSession.rollback();
				return new CommandResult(Constant.textPlain, Constant.productInsertionError);
			}

			product = insertImageOfProduct(user, product, uploadedFilePaths);
			if (product == null) {
				sqlSession.rollback();
				return new CommandResult(Constant.textPlain, Constant.productInsertionError);
			}

			if (!insertCategoryOfProudct(product)) {
				sqlSession.rollback();
				return new CommandResult(Constant.textPlain, Constant.productInsertionError);
			}

		} finally {
			sqlSession.commit();
			sqlSession.close();
		}

		return new CommandResult("/WEB-INF/view/mainView/main.jsp");
	}

	private List<String> uploadFiles() throws IOException {
		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUploadAbsolutePath);

		TimestampFileRenamePolicy fileRenamePolicy = new TimestampFileRenamePolicy();
		if (getMulti() == null)
			setMulti(new MultipartRequest(request, filePath, 500 * 1024, "UTF-8", fileRenamePolicy));

		List<String> uploadedFilePaths = new ArrayList<>();
		List<String> newFileNames = fileRenamePolicy.getNewFileNames();
		for (int i = 0; i < newFileNames.size(); i++) {
			String fileRelativePath = "";
			String fileUploadPath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
			fileRelativePath = fileUploadPath + newFileNames.get(i);
			uploadedFilePaths.add(fileRelativePath);
		}
		return uploadedFilePaths;
	}

	private Product insertProduct(User user) throws IOException {
		Product product = null;
		InsertProductParams psParam = new InsertProductParams(multi);
		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		product = new Product(user.getUserId(), psParam.getProductName(), psParam.getPrice(), psParam.getStock(), psParam.getTransactionType(),
				psParam.getConnectionOpt(), psParam.getTags(), psParam.getDescription(), 0, false, true, false);
		productMapper.insertProduct(product);

		return product;
	}

	private Product insertImageOfProduct(User user, Product product, List<String> uploadedFilePaths) throws IOException {
		Product productFound = null;
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		List<Product> products = userMapper.getAllProducts(user.getUserId());
		Iterator<Product> iterProduct = products.iterator();

		while (iterProduct.hasNext()) {
			Product productNext = iterProduct.next();
			if (!productNext.equals(product))
				continue;

			productFound = productNext;
			break;
		}

		if (productFound == null)
			return null;

		ProductImageMapper imageMapper = sqlSession.getMapper(ProductImageMapper.class);
		for (int i = 0; i < uploadedFilePaths.size(); i++) {
			ProductImage psImage = new ProductImage(productFound.getProductId(), uploadedFilePaths.get(i));
			imageMapper.insertImage(psImage);
		}

		return productFound;
	}

	private boolean insertCategoryOfProudct(Product product) throws IOException {
		String categoryName = multi.getParameter("miniCategory");

		if (categoryName == "" || categoryName == null)
			return false;

		String[] categorySplited = categoryName.split(">");

		String categoryLastName = categorySplited[categorySplited.length - 1].trim();

		CategoryMapper categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		Category category = categoryMapper.getCategoryByName(categoryLastName);
		if (category == null)
			return false;

		ProductCategoryMapper productCategoryMapper = sqlSession.getMapper(ProductCategoryMapper.class);
		ProductCategory productAndCategory = new ProductCategory(category.getCategoryId(), product.getProductId());
		productCategoryMapper.insertProductCategory(productAndCategory);

		return true;
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

			return productInfo;

		} finally {
			sqlSession.close();
		}
	}

	public MultipartRequest getMulti() {
		return multi;
	}

	public void setMulti(MultipartRequest multi) {
		this.multi = multi;
	}

	public CommandResult setSearchedProductDatas() {
		// [TODO]: 데이터 쿼리하는 코드 필요. ( 현재는 그냥 샘플 사용 )

		String keywords = request.getParameter(Constant.attrKeywords);
		String dataPage = request.getParameter(Constant.attrDataPage);
		String sortCondition = request.getParameter(Constant.attrSort);

		if (dataPage == null || dataPage.equals("")) {
			dataPage = "1";
		}

		if (sortCondition == null || sortCondition.equals("")) {
			sortCondition = "1";
		}

		HttpSession session = request.getSession();
		SearchResult searchResult = (SearchResult) session.getAttribute(Constant.attrSearchResult);

		if (keywords == null || keywords == "")
			return null;

		if (searchResult == null || !searchResult.getKeywords().equals(keywords)) {
 
			List<SearchResultParam> searchResults = new ArrayList<>();

			for (int i = 0; i < 67; i++) {
				searchResults.add(new SearchResultParam("product$Id" + i, "name" + i, "products" + i, 100 * (i + 1), "200000" + i, false, "C:/" + i
						+ ".png", "location" + i, "" + i));
			}

			searchResult = new SearchResult(Integer.parseInt(dataPage), keywords, Integer.parseInt(sortCondition), searchResults);
			session.setAttribute(Constant.attrSearchResult, searchResult);

		} else {
			searchResult.setKeywords(keywords);
			searchResult.setCurrentPage(Integer.parseInt(dataPage));
			searchResult.setSortCondition(Integer.parseInt(sortCondition));
		}

		return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");
	}
}