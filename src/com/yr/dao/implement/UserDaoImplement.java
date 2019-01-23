package com.yr.dao.implement;

import java.math.BigInteger;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.yr.dao.UserDao;
import com.yr.entity.Page;
import com.yr.entity.Role;
import com.yr.entity.User;

@Repository
public class UserDaoImplement implements UserDao{

	@Resource
    private SessionFactory sessionFactory;
	
	@Override
	public Page<User> query(Page<User> page) {
		Session session=sessionFactory.getCurrentSession();
		int startIndex = page.getPageSize() * (page.getPage()-1);
		int pageSize = page.getPageSize();
		Query q = session.createQuery("from User").setFirstResult(startIndex).setMaxResults(pageSize);
		//查询总数
		Query q1 = session.createNativeQuery("select count(*) from User");
		BigInteger count = (BigInteger) q1.getSingleResult();
		page.setPageSizeCount(count.intValue());
		List<User> listRole= q.getResultList();
		page.setT(listRole);
		return page;
	}
	
	@Override
	public String addUser(User user) {
		Session session=sessionFactory.getCurrentSession();
		Role role=session.get(Role.class,2);
		user.getRoleSet().add(role);
		session.save(user);
		return "success";
	}

	@Override
	public void deleteUser(Integer userId) {
		Session session=sessionFactory.getCurrentSession();
		Query query=session.createQuery("delete from User where id=?");
		query.setParameter(0,userId);
		query.executeUpdate();
	}
	@Override
	public String findOut(String account) {
		Session session=sessionFactory.getCurrentSession();
		Query query=session.createQuery("select count(*) from User where account=?");
		Long result=(Long) query.setParameter(0,account).getSingleResult();
		return String.valueOf(result);
	}

	@Override
	public String queryIsNull() {
		Session session=sessionFactory.getCurrentSession();
		Long result=(Long) session.createQuery("select count(*) from User").getSingleResult();
		return String.valueOf(result);
	}

	@Override
	public User queryToId(Integer id) {
		Session session=sessionFactory.getCurrentSession();
		User user=session.get(User.class,id);
		return user;
	}

	@Override
	public void updateUser(String userName, String account,Integer userId) {
		Session session=sessionFactory.getCurrentSession();
		User user=session.get(User.class,userId);
		user.setUserName(userName);
		user.setAccount(account);
		session.save(user);
	}
}