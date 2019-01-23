package com.yr.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yr.dao.UserDao;
import com.yr.entity.Page;
import com.yr.entity.User;
import com.yr.service.UserService;

@Service
public class UserServiceImplement implements UserService{

	@Autowired
	private UserDao userDao;
	

	@Override
	public Page<User> query(Page<User> page) {
		page=userDao.query(page);
		return page;
	}
	
	@Transactional
	@Override
	public String addUser(User user) {
		String result=findOut(user.getAccount());
		if("0".equals(result)){
			return userDao.addUser(user);
		}else{
			return "fail";
		}
	}
	
	
	public String findOut(String account){
		String result=userDao.findOut(account);
		return result;
	}
	
	
	@Transactional
	@Override
	public String deleteUser(Integer userId) {
		String returnValue="";
			userDao.deleteUser(userId);
			String query=userDao.queryIsNull();
			if("0".equals(query)){
				returnValue="null";
			}else{
				returnValue="deleteSuccess";
			}
		return returnValue;
		       
	}

	@Override
	public User queryToId(Integer id) {
		
		User user=userDao.queryToId(id);
		return user;
	}
	@Transactional
	@Override
	public void updateUser(String userName, String account,Integer userId) {
		String result=userDao.findOut(account);
		if("0".equals(result)){
			userDao.updateUser(userName,account,userId);
		}else{
			System.out.println("该账号已存在");
		}
		
	}
}
