package com.yr.service;

import com.yr.entity.User;

public interface LoginService {
	public String login(User user);
	
	public String queryPassword(String account);
	
	public String updatePassword(String password,String account);
	
}
