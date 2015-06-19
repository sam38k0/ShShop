package com.shshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shshop.domain.Address;
import com.shshop.domain.AddressProc;
import com.shshop.domain.Product;
import com.shshop.domain.User;

public interface UserMapper {
	public int getUserCount();

	public User getUserById(@Param("userId") int userId);

	public User getUserByEmail(@Param("email") String email, @Param("password") String password);

	public List<User> getAllUsers();

	public User getSelectUserId(@Param("email") String email);

	public User getSingleUser(@Param("userId") int userId);

	public void insertUserByEmail(User user);

	public void insertUser(User user);

	public List<Product> getAllProducts(@Param("userId") int userId);

	public void updateUser(User user);

	public List<Address> getUserAddress(@Param("userId") int userId);

	public void insertAddress(Address address);

	public void insertAddressProc(AddressProc address);

	public void updateUserAddress(Address address);
}
