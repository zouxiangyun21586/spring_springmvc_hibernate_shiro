package com.yr.entity;

import java.util.HashSet;
import java.util.Set;

public class Role{
	
	public Integer id;
	
	public String roleName;
	
	public Set<User> userSet=new HashSet<>();
	
	public Set<Jurisdiction> jurisdictionSet=new HashSet<>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Set<User> getUserSet() {
		return userSet;
	}

	public void setUserSet(Set<User> userSet) {
		this.userSet = userSet;
	}

	public Set<Jurisdiction> getJurisdictionSet() {
		return jurisdictionSet;
	}

	public void setJurisdictionSet(Set<Jurisdiction> jurisdictionSet) {
		this.jurisdictionSet = jurisdictionSet;
	}
	
	@Override
	public String toString() {
		return "Role [id=" + id + ", roleName=" + roleName + ", jurisdictionSet="
				+ jurisdictionSet + "]";
	}
}
