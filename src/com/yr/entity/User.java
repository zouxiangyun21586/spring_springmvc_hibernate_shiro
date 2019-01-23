package com.yr.entity;

import java.util.HashSet;
import java.util.Set;

public class User{

	public Integer id;
	
	public String userName;
	

	public String account;
	
	public String password;
	
	public Set<Role> roleSet=new HashSet<>();

	public Set<Role> getRoleSet() {
		return roleSet;
	}

	public void setRoleSet(Set<Role> roleSet) {
		this.roleSet = roleSet;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", account=" + account + ", password=" + password
				+ ", roleSet=" + roleSet + "]";
	}
	

}
