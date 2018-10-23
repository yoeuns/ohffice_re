package com.project.ohffice.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.board.model.vo.Division;

@Repository("divisionDao")
public class DivisionDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public DivisionDao() {}
	
	public ArrayList<Division> divisionList() {
		return (ArrayList)sqlSession.selectList("divisionMapper.selectDivisionList");
	}

	public int insertDivision(Map map) {
		return sqlSession.insert("divisionMapper.insertDivision", map);
	}

	public int updateDivision(Map map) {
		return sqlSession.update("divisionMapper.updateDivision", map);
	}

	public int deleteDivision(String division_num) {
		return sqlSession.delete("divisionMapper.deleteDivision", division_num);
	}

	public int selectDivisionNum() {
		int result;
		
		if(sqlSession.selectOne("divisionMapper.selectDivisionNum") == null)
			result = 0;
		else
			result = sqlSession.selectOne("divisionMapper.selectDivisionNum");
		
		return result;			
	}

	public int createBoardTable(int division_num) {
		String sql = 
				"create table board" + division_num + 
				" (board_num number(38,0) primary key, " +
				"com_url varchar2(300), " +
				"board_email varchar2(80), " +
				"division_num number(38,0), " +
				"board_title varchar2(300), " +
				"board_content varchar2(2000), " +
				"board_date date default sysdate, " +
				"board_count number(38,0) default '0', " +
				"foreign key(com_url) references company(com_url), " +
				"foreign key(board_email) references employee(emp_email), " +
				"foreign key(division_num) references division(division_num))";

		HashMap map = new HashMap();
		map.put("sql", sql);
				
		return sqlSession.update("createTable", map);
	}

	public int visibleN(String com_url) {
		return sqlSession.update("divisionMapper.visibleN", com_url);
	}

	public int visibleY(String division_num) {
		return sqlSession.update("divisionMapper.visibleY", division_num);
	}

}
