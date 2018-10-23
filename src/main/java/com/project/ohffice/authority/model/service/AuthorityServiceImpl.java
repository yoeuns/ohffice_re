package com.project.ohffice.authority.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.authority.model.dao.AuthorityDao;
import com.project.ohffice.authority.model.vo.Authority;

@Service("authService")
public class AuthorityServiceImpl implements AuthorityService {

	@Autowired
	private AuthorityDao authDao;

	@Override
	public ArrayList<Authority> authList() {
		return authDao.authList();
	}

}
