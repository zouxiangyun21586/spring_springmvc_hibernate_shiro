package com.yr.dao.implement;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.yr.dao.LoginDao;
import com.yr.entity.User;

@Repository
public class LoginDaoImplement implements LoginDao{
	
	@Resource
    private SessionFactory sessionFactory;
	
	
	public String isNull(){
		Session session=sessionFactory.getCurrentSession();
		Query query=session.createQuery("select count(*) from User");
		Long result=(long) query.uniqueResult();
		return String.valueOf(result);
	}
	
	@Override
	public String login(User user){
		Session session=sessionFactory.getCurrentSession();
		Query query=session.createQuery("select count(*) from User  where account=? and password=?").setParameter(0,user.getAccount()).setParameter(1,user.getPassword());
		Long result=(long) query.uniqueResult();
		return String.valueOf(result);
	}
	
	@Override
	public String queryPassword(String account) {
		Session session=sessionFactory.getCurrentSession();
		String sql="select password from User where account=?";
		Query query=session.createQuery(sql).setParameter(0,account);
		String result=(String) query.uniqueResult();
		return result;
	}
	
	@Override
	public String updatePassword(String password, String account) {
		Session session=sessionFactory.getCurrentSession();
		String sql="update User set password=? where account=?";
		Query query=session.createQuery(sql).setParameter(0,password).setParameter(1, account);
		Integer result=query.executeUpdate();
		return String.valueOf(result);
	}
}
