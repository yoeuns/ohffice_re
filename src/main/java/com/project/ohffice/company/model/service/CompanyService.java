package com.project.ohffice.company.model.service;

import java.util.HashMap;

import com.project.ohffice.company.model.vo.Company;

public interface CompanyService {

	int insertComp(Company comp);
	
	String comName(String com_url);

	public abstract Company comInfo(String comURL);
	
	int createBoard(HashMap map);
	
	public abstract int comChangeMethod(Company com);
	
	public abstract Company infoCom(String comURL);

}
