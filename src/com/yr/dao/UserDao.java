package com.yr.dao;

import java.util.List;

import com.yr.entity.Page;
import com.yr.entity.User;

public interface UserDao {
	public Page<User> query(Page<User> page);
	
	public String findOut(String account);
	
	public String addUser(User user);
	
	public void deleteUser(Integer userId);
	
	public String queryIsNull();
	
	public User queryToId(Integer id);
	
	public void updateUser(String userName,String account,Integer userId);
	
	
}
