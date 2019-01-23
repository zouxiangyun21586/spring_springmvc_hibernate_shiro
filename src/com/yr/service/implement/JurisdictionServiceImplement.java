package com.yr.service.implement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yr.dao.JurisdictionDao;
import com.yr.service.JurisdictionService;

@Service
public class JurisdictionServiceImplement implements JurisdictionService{
	
	@Autowired
	private JurisdictionDao jurisdictionDao;
	
}
