package com.yr.entity;

import java.util.HashSet;
import java.util.Set;

public class Jurisdiction{
	
	public Integer id;
	
	public String url;

	public String permissionDescription;
	
	public Set<Role> roleSet=new HashSet<>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPermissionDescription() {
		return permissionDescription;
	}

	public void setPermissionDescription(String permissionDescription) {
		this.permissionDescription = permissionDescription;
	}

	public Set<Role> getRoleSet() {
		return roleSet;
	}

	public void setRoleSet(Set<Role> roleSet) {
		this.roleSet = roleSet;
	}

	@Override
	public String toString() {
		return "Jurisdiction [id=" + id + ", url=" + url + ", permissionDescription=" + permissionDescription+"]";
	}

	

}
