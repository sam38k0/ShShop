package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Category;
import com.shshop.domain.Product;

public interface CategoryMapper {
	public int getCategoryCount();

	public Category getCategoryById(@Param("categoryId") int categoryId);

	public Category getCategoryByName(@Param("name") String name);

	public List<Category> getChildrenCategories(Category category);

	public List<Category> getRootCategories();

	public List<Product> getAllProducts(@Param("categoryId") int categoryId);

	public List<Product> getCategoryProducts(@Param("name") String name);

	public void insertRootCategory(Category category);

	public void insertChildCategory(Category category);

	public void updateCategory(Category category);

	public void deleteCategory(@Param("categoryId") int categoryId);

	// 현재 노드 기준으로 Depth3 까지만 검색한다.
	// 모든 노드를 검색하지 않지만 카테고리의 영역이 최대 3을 넘지 않도록 디자인된 사이트라서
	// 실제로 모든 노드를 검색하는 것보다는 현실적인 속도를 높히기 위해 추가한다.
	//
	// public List<CategoryNodeInfos> getCategoryNodeInfos();
}
