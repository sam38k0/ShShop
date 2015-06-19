package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Address;
import com.shshop.domain.AddressProc;

public interface AddressMapper {
	public int getAddressCount();

	public Address getAddressById(@Param("idAddress") int idAddress);
	
	public List<Address> getAllAddress();

	public void insertAddress(Address address);

	public void insertAddressProc(AddressProc address);

	public void updateAddress(Address address);

	public void deleteAddress(@Param("idAddress") int idAddress);
}
