package com.project.ohffice.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.board.model.vo.Board;

@Repository("boardDao")
public class BoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Board> boardList(String value) {
	      return (ArrayList)sqlSession.selectList("boardMapper.boardSelectList", value);
	   }

	public int insertBoard(Map map) {
		
		if(map.get("param1").equals("0")){
			return sqlSession.insert("boardMapper.insertBasic", map);
		}else{
			return sqlSession.insert("boardMapper.insertBoard", map);
		}
	}

	public Board selectBoard(Map<String, String> map) {
		if(map.get("param1").equals("0")){
			return sqlSession.selectOne("boardMapper.SelectBasic", map);
		}else{
		return sqlSession.selectOne("boardMapper.SelectBoard", map);
		}
	}

	public int updateBoard(Map map) {
		if(map.get("param1").equals("0")){
			return sqlSession.update("boardMapper.updateBasic", map);
		}else{
			return sqlSession.update("boardMapper.updateBoard", map);
		}
	}

	public int deleteBoard(Map map) {
		
		if(map.get("param1").equals("0")){
			return sqlSession.delete("boardMapper.deleteBasic", map);
		}else{
			return sqlSession.delete("boardMapper.deleteBoard", map);
		}
		
	}

}
