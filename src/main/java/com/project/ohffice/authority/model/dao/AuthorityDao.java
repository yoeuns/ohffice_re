package com.project.ohffice.authority.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.authority.model.vo.Authority;

@Repository("authDao")
public class AuthorityDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Authority> authList() {
		return (ArrayList)sqlSession.selectList("authorityMapper.selectAuthList");
	}

}
