package com.shshop.service;

import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.shshop.domain.Category;
import com.shshop.helper.CategoryHtmlBuilder;
import com.shshop.mapper.CategoryMapper;
import com.shshop.util.MyBatisUtil;

public class CategoryControlService {
	private SqlSession sqlSession = null;
	private static String buildHtmlResult = "";
	private static String buildHtmlResult2 = "";
	
	public CategoryControlService() {

	}

	public String buildHtml(boolean forceOperation, boolean withSearchQuery) {
		if (!forceOperation) {
			try {
				while (getBuildHtmlResult().equals(""))
					Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			if(withSearchQuery)
				return getBuildHtmlResult();
			else
				return getBuildHtmlResult2();
		}
	
		String result = "";
		String result2 = "";

		try {
			CategoryMapper categoryMapper = getCategoryMapper();
			CategoryHtmlBuilder categoryHtmlBuilderRoot = new CategoryHtmlBuilder("allcategory");
			
			List<Category> rootCategories = categoryMapper.getRootCategories();
			Iterator<Category> iter = rootCategories.iterator();
			while (iter.hasNext()) {
				Category category = iter.next();
				CategoryHtmlBuilder categoryHtmlBuilderChild = new CategoryHtmlBuilder(category);
				categoryHtmlBuilderRoot.add(categoryHtmlBuilderChild);
				buildHtmlRecursive(categoryHtmlBuilderChild, category);
			}
			
			result = categoryHtmlBuilderRoot.buildHtml();
			result2 = categoryHtmlBuilderRoot.buildHtml2();
			
		} finally {
			closeMapper();
		}

		setBuildHtmlResult(result);
		setBuildHtmlResult2(result2);
		
		if(withSearchQuery)
			return getBuildHtmlResult();
		else
			return getBuildHtmlResult2();
	}

	private void buildHtmlRecursive(CategoryHtmlBuilder categoryParentItem, Category parentCategory) {
		try {
			CategoryMapper categoryMapper = getCategoryMapper();
			List<Category> rootCategories = categoryMapper.getChildrenCategories(parentCategory);
			
			Iterator<Category> iter = rootCategories.iterator();
			while (iter.hasNext()) {
				Category nextCategory = iter.next();
				CategoryHtmlBuilder categoyBuilderChild = new CategoryHtmlBuilder(nextCategory);
				categoryParentItem.add(categoyBuilderChild);
				buildHtmlRecursive(categoyBuilderChild, nextCategory);
			}
		} finally {
			closeMapper();
		}
	}

	private void closeMapper() {
		if (sqlSession != null)
			sqlSession.close();
	}

	private CategoryMapper getCategoryMapper() {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		return sqlSession.getMapper(CategoryMapper.class);
	}

	public static String getBuildHtmlResult() {
		return buildHtmlResult;
	}
	
	public static String getBuildHtmlResult2() {
		return buildHtmlResult2;
	}

	public static void setBuildHtmlResult(String buildHtmlResult) {
		CategoryControlService.buildHtmlResult = buildHtmlResult;
	}
	
	public static void setBuildHtmlResult2(String buildHtmlResult) {
		CategoryControlService.buildHtmlResult2 = buildHtmlResult;
	}
	
}
