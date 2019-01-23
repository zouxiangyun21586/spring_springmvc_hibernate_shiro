package com.yr.dao.implement;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.yr.dao.JurisdictionDao;
import com.yr.entity.Jurisdiction;
import com.yr.entity.Role;
import com.yr.entity.User;

@Repository
public class JurisdictionDaoImplement implements JurisdictionDao{
	
	@Resource
    private SessionFactory sessionFactory;

	@Override
	public Set<Jurisdiction> queryUserToJurisdiction(String account) {
		Session session=sessionFactory.getCurrentSession();
		List<User> userSet= session.createQuery("from User where account=?").setParameter(0,account).list();
		Set<Jurisdiction> jurisdictionSet=null;
		for (User user : userSet) {
			Set<Role> roleSet=user.getRoleSet();
			for (Role role : roleSet) {
				jurisdictionSet=role.getJurisdictionSet();
			}
		}
		return jurisdictionSet;
	}

	
	
}
