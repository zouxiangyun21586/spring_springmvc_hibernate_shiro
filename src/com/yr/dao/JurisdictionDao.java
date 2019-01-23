package com.yr.dao;

import java.util.Set;

import com.yr.entity.Jurisdiction;

public interface JurisdictionDao {

	
	public Set<Jurisdiction> queryUserToJurisdiction(String account);
}
