package com.yr.dao;

import com.yr.entity.User;

public interface LoginDao {
	public String isNull();
	
	public String login(User user);
	
	public String queryPassword(String account);
	
	public String updatePassword(String password,String account);
	
	
}
