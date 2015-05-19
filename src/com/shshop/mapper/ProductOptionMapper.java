package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.ProductOption;

public interface  ProductOptionMapper {
	public int getOptionCount();
 
	public ProductOption getOptionById(@Param("optionId") int optionId);
	
	public List<ProductOption> getChildrenOptions(ProductOption option);

	public void updateOption(ProductOption option);
	
	public void deleteOption(@Param("optionId") int optionId);
}
