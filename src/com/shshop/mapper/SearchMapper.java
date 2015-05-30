package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Product;


public interface SearchMapper {

	public List<Product> getSearching(@Param("keyword")String keyword);

}
