package com.yr.service.implement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yr.dao.LoginDao;
import com.yr.entity.User;
import com.yr.service.LoginService;

@Service
public class LoginServiceImplement implements LoginService{
	
	@Autowired
	private LoginDao loginDao;

	@Override
	public String login(User user) {
		String value=loginDao.isNull();
		if("0".equals(value)){
			return "isNull";
		}else{
			String result=loginDao.login(user);
			return result;
		}
	}

	@Override
	public String queryPassword(String account) {
		String result=loginDao.queryPassword(account);
		return result;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)//提交事务
	@Override
	public String updatePassword(String password, String account) {
		String result=loginDao.updatePassword(password,account);
		return result;
	}
}
