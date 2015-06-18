package com.shshop.mapper;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Address;

public interface AddressMapper {
	public int getAddressCount();
	
	public Address getAddressById(@Param("idAddress") int idAddress);
}
