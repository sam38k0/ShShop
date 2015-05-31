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
		
		HttpSession session = request.getSession();
		
		if(keywords == null) {
			keywords = (String)session.getAttribute(Constant.attrKeywords);
			dataPage = (String)session.getAttribute(Constant.attrDataPage);
		}
		
		SearchResult searchResult = (SearchResult) session.getAttribute(Constant.attrSearchResult);
		
		synchronized(session) {
			session.setAttribute(Constant.attrKeywords, "");
			session.setAttribute(Constant.attrDataPage, "");
		}
		
		if(keywords == null || keywords == "" || dataPage == null)
			return null;
		
		if (searchResult == null || !searchResult.getKeywords().equals(keywords) ) {
			// 결과를 쿼리 한다.
			List<SearchResultParam> searchResults = new ArrayList<>();
			searchResults.add(new SearchResultParam("product$Id1", "a", "ps1", 100, "20000001", false, "C:/1.png", "location1", "1"));
			searchResults.add(new SearchResultParam("product$Id2", "b", "ps2", 200, "20000002", false, "C:/2.png", "location2", "2"));
			searchResults.add(new SearchResultParam("product$Id3", "c", "ps3", 300, "20000003", false, "C:/3.png", "location3", "1"));
			searchResults.add(new SearchResultParam("product$Id4", "d", "ps4", 400, "20000004", false, "C:/4.png", "location4", "2"));
			searchResults.add(new SearchResultParam("product$Id5", "e", "ps5", 500, "20000005", false, "C:/5.png", "location5", "1"));
			searchResults.add(new SearchResultParam("product$Id6", "f", "ps6", 600, "20000006", false, "C:/6.png", "location6", "4"));
			searchResults.add(new SearchResultParam("product$Id7", "g", "ps7", 700, "20000007", false, "C:/7.png", "location7", "1"));
			searchResults.add(new SearchResultParam("product$Id8", "h", "ps8", 800, "20000008", false, "C:/8.png", "location8", "5"));
			searchResults.add(new SearchResultParam("product$Id9", "i", "ps9", 900, "20000009", false, "C:/9.png", "location9", "1"));
			searchResults.add(new SearchResultParam("product$Id10", "j", "ps10", 1000, "20000010", false, "C:/10.png", "location10", "1"));
			searchResults.add(new SearchResultParam("product$Id11", "k", "ps11", 1100, "20000011", false, "C:/11.png", "location11", "1"));
			searchResults.add(new SearchResultParam("product$Id12", "l", "ps12", 1200, "20000012", false, "C:/12.png", "location12", "1"));
			searchResults.add(new SearchResultParam("product$Id13", "m", "ps13", 1300, "20000013", false, "C:/13.png", "location13", "1"));
			searchResults.add(new SearchResultParam("product$Id14", "n", "ps14", 1400, "20000014", false, "C:/14.png", "location14", "1"));
			searchResults.add(new SearchResultParam("product$Id15", "o", "ps15", 1500, "20000015", false, "C:/15.png", "location15", "5"));
			searchResults.add(new SearchResultParam("product$Id16", "p", "ps16", 1600, "20000016", false, "C:/16.png", "location16", "1"));
			searchResults.add(new SearchResultParam("product$Id17", "q", "ps17", 1700, "20000017", false, "C:/17.png", "location17", "3"));
			searchResults.add(new SearchResultParam("product$Id18", "r", "ps18", 1800, "20000018", false, "C:/18.png", "location18", "1"));
			searchResults.add(new SearchResultParam("product$Id19", "s", "ps19", 1900, "20000019", false, "C:/19.png", "location19", "1"));
			searchResults.add(new SearchResultParam("product$Id20", "t", "ps20", 2000, "20000020", false, "C:/20.png", "location20", "4"));
			searchResults.add(new SearchResultParam("product$Id21", "u", "ps21", 2100, "20000021", false, "C:/21.png", "location21", "1"));
			searchResults.add(new SearchResultParam("product$Id22", "v", "ps22", 2200, "20000022", false, "C:/22.png", "location22", "2"));
			searchResults.add(new SearchResultParam("product$Id23", "w", "ps23", 2300, "20000023", false, "C:/23.png", "location23", "1"));
			searchResults.add(new SearchResultParam("product$Id24", "x", "ps24", 2400, "20000024", false, "C:/24.png", "location24", "2"));
			searchResults.add(new SearchResultParam("product$Id25", "y", "ps25", 2500, "20000025", false, "C:/25.png", "location25", "3"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			searchResults.add(new SearchResultParam("product$Id26", "z", "ps26", 2600, "20000026", false, "C:/26.png", "location26", "1"));
			
			searchResult = new SearchResult(Integer.parseInt(dataPage),keywords,searchResults);
			session.setAttribute(Constant.attrSearchResult, searchResult);

		} else {
			searchResult.setCurrentPage(Integer.parseInt(dataPage));
		}

		return new CommandResult("/WEB-INF/view/searchView/searchActionJsonData.jsp");
	}
}