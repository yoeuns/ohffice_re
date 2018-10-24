package com.project.ohffice.position.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.position.model.vo.Position;

@Repository("posDao")
public class PositionDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Position> posList(String com_url) {
		return (ArrayList) sqlSession.selectList("positionMapper.selectList", com_url);
	}

	public int insertPos(Position pos) {
		return sqlSession.insert("positionMapper.insertPosition", pos);
	}

	public int updatePos(Position pos) {
		return sqlSession.update("positionMapper.updatePosition", pos);
	}

	public int deletePos(String pos_num) {
		return sqlSession.delete("positionMapper.deletePosition", pos_num);
	}
	
	
}
