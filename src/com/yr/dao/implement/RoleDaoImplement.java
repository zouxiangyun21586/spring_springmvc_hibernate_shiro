package com.yr.dao.implement;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.yr.dao.RoleDao;
import com.yr.entity.Role;
import com.yr.entity.User;

@Repository
public class RoleDaoImplement implements RoleDao{
	@Resource
    private SessionFactory sessionFactory;

	@Override
	public Set<Role> queryUserToRole(String account) {
		Session session=sessionFactory.getCurrentSession();
		List<User> userList=session.createQuery("from User where account=?").setParameter(0,account).list();
		Set<Role> setRole=null;
		for (User user : userList) {
			setRole = user.getRoleSet();
		}
		return setRole;
	}
}
