package com.yr.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yr.dao.RoleDao;
import com.yr.entity.Role;
import com.yr.service.RoleService;

@Service
public class RoleServiceImplement implements RoleService{
	
	@Autowired
	private RoleDao roleDao;

	@Override
	public List<Role> query() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
