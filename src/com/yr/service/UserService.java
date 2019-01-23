package com.yr.service;

import java.util.List;

import com.yr.entity.Page;
import com.yr.entity.User;

public interface UserService {
	
	public Page<User> query(Page<User> page);
	
	public String addUser(User user);
	
	public String deleteUser(Integer userId);
	
	public String findOut(String account);
	
	public User queryToId(Integer id);
	
	public void updateUser(String userName,String account,Integer userId);
}
