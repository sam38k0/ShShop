package com.shshop.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.shshop.domain.Product;
import com.shshop.mapper.SearchMapper;
import com.shshop.util.MyBatisUtil;

public class ProductSearchService {
	private SqlSession sqlSession = null;
	
	public ProductSearchService(){
		
	}
	public List<Product> getSearching(String keyword) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		List<Product> products = null;
		
		try {
			SearchMapper searchMapper = sqlSession.getMapper(SearchMapper.class);
			products = searchMapper.getSearching(keyword);

		} finally {
			sqlSession.close();
		}

		return products;
	}
	
}
