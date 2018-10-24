package com.project.ohffice.company.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.company.model.vo.Company;

@Repository("companyDao")
public class CompanyDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertComp(Company comp) {		

		return sqlSession.insert("companyMapper.companyInsert",comp);
	}

	public String comName(String com_url) {
		return sqlSession.selectOne("companyMapper.comName", com_url);
	}

	public Company comInfo(String comURL) {	      
		return sqlSession.selectOne("companyMapper.comInfo", comURL);  
	}

	public int createBoard(HashMap map) {
		String sql = 
				"create table board" + map.get("com_url") + 
				" (board_num number(38,0) primary key, " +
				"com_url varchar2(300), " +
				"board_email varchar2(80), " +
				"board_title varchar2(300), " +
				"board_content varchar2(2000), " +
				"board_date date default sysdate, " +
				"board_count number(38,0) default '0', " +
				"foreign key(com_url) references company(com_url), " +
				"foreign key(board_email) references employee(emp_email))";

		HashMap map1 = new HashMap();
		map1.put("sql", sql);

		return sqlSession.update("createTable1", map1);
	}

	public int comChangeMethod(Company com) {

		return sqlSession.update("companyMapper.comChangeMethod", com);

	}

	public Company infoCom(String comURL) {

		return sqlSession.selectOne("companyMapper.infoCom", comURL);  

	}

}
