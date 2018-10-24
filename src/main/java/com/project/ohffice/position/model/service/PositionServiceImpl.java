package com.project.ohffice.position.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.position.model.dao.PositionDao;
import com.project.ohffice.position.model.vo.Position;

@Service("posService")
public class PositionServiceImpl implements PositionService {
	@Autowired
	private PositionDao posDao;

	@Override
	public ArrayList<Position> posList(String com_url) {
		return posDao.posList(com_url);
	}

	@Override
	public int insertPos(Position pos) {
		return posDao.insertPos(pos);
	}

	@Override
	public int updatePos(Position pos) {
		return posDao.updatePos(pos);
	}

	@Override
	public int deletePos(String pos_num) {
		return posDao.deletePos(pos_num);
	}
}
