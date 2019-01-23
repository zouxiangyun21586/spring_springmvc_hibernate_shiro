package com.yr.dao;


import java.util.Set;

import com.yr.entity.Role;

public interface RoleDao {
	
	
	
	
	
	public Set<Role> queryUserToRole(String account);
}
