package com.shshop.service;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Category;
import com.shshop.domain.Product;
import com.shshop.domain.ProductCategory;
import com.shshop.domain.ProductImage;
import com.shshop.domain.User;
import com.shshop.mapper.CategoryMapper;
import com.shshop.mapper.ProductCategoryMapper;
import com.shshop.mapper.ProductImageMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.util.MyBatisUtil;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSession;


@SuppressWarnings("unused")
public class ProductService {
	private SqlSession sqlSession = null;
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;

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
			Product product = insertProduct(user);
			if (product == null) {
				sqlSession.rollback();
				return new CommandResult(Constant.textPlain, Constant.productInsertionError);
			}

			product = insertImageOfProduct(user, product);
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

		return new CommandResult("/WEB-INF/view/main.jsp");
	}

	private Product insertProduct(User user) throws IOException {
		Product product = null;

		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
		MultipartRequest multi = new MultipartRequest(request, filePath, 500 * 1024, "utf-8", new DefaultFileRenamePolicy());

		String productName = multi.getParameter("productname");
		String price = multi.getParameter("price");
		String stock = multi.getParameter("stock");
		String description = multi.getParameter("description");
		String tags = multi.getParameter("tagsinput");
		String category = multi.getParameter("miniCategory");

		ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
		product = new Product(user.getUserId(), productName, Integer.parseInt(price), Integer.parseInt(stock), false, true, tags, false, description,
				0);
		productMapper.insertProduct(product);

		return product;
	}

	private Product insertImageOfProduct(User user, Product product) throws IOException {
		List<String> uploadedFilePaths = fileUpload();

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
		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
		MultipartRequest multi = new MultipartRequest(request, filePath, 500 * 1024, "utf-8", new DefaultFileRenamePolicy());
		String categoryName = multi.getParameter("miniCategory");

		if (categoryName == "" || categoryName == null)
			return false;

		String[] categorySplited = categoryName.split("categoryName");

		String categoryLastName = categorySplited[categorySplited.length - 1];

		CategoryMapper categoryMapper = sqlSession.getMapper(CategoryMapper.class);
		Category category = categoryMapper.getCategoryByName(categoryLastName);

		ProductCategoryMapper productCategoryMapper = sqlSession.getMapper(ProductCategoryMapper.class);
		ProductCategory productAndCategory = new ProductCategory(category.getCategoryId(), product.getProductId());
		productCategoryMapper.insertProductCategory(productAndCategory);

		return true;
	}

	private List<String> fileUpload() throws IOException {

		File file;
		int maxFileSize = 500 * 1024;
		int maxMemSize = 10 * 1024; // √÷¥Î 1MB
		String filePath = request.getServletContext().getInitParameter(Constant.paramFileUpload);
		String repositoryPath = request.getServletContext().getInitParameter(Constant.paramFileUploadRepository);

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if (!isMultipart)
			return null;

		List<String> uploadedFilePaths = new ArrayList<>();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File(repositoryPath));

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);

		try {
			List<FileItem> fileItems = upload.parseRequest(request);

			Iterator<FileItem> i = fileItems.iterator();

			while (i.hasNext()) {
				FileItem fileItem = (FileItem) i.next();
				if (!fileItem.isFormField()) {
					String fileName = fileItem.getName();

					if (fileName.equals("") || fileName == null)
						continue;

					String fileFullPath = "";
					if (fileName.lastIndexOf("\\") >= 0)
						fileFullPath = filePath + fileName.substring(fileName.lastIndexOf("\\"));
					else
						fileFullPath = filePath + fileName.substring(fileName.lastIndexOf("\\") + 1);

					uploadedFilePaths.add(fileFullPath);

					file = new File(fileFullPath);

					fileItem.write(file);
				}
			}
		} catch (Exception ex) {
			System.out.println(ex);
			return null;
		}

		return uploadedFilePaths;
	}
}