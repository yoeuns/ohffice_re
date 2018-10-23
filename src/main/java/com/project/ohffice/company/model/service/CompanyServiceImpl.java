package com.project.ohffice.company.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.company.model.dao.CompanyDao;
import com.project.ohffice.company.model.vo.Company;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	private CompanyDao companyDao;

	@Override
	public int insertComp(Company comp) {

		return companyDao.insertComp(comp);
	}

	@Override
	public String comName(String com_url) {
		return companyDao.comName(com_url);
	}

	@Override
	public Company comInfo(String comURL) {

		return companyDao.comInfo(comURL);

	}
	
	@Override
	public int comChangeMethod(Company com) {
		
		return companyDao.comChangeMethod(com);
		
	}

	@Override
	public int createBoard(HashMap map) {
		return companyDao.createBoard(map);

	}

}
