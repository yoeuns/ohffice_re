package com.project.ohffice.board.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.board.model.dao.DivisionDao;
import com.project.ohffice.board.model.vo.Division;

@Service("divisionService")
public class DivisionServiceImpl implements DivisionService {
	
	@Autowired
	private DivisionDao divisionDao;
	
	public DivisionServiceImpl() {}
	
	@Override
	public ArrayList<Division> divisionList() {		
		return divisionDao.divisionList();
	}

	@Override
	public int insertDivision(Map map) {
		return divisionDao.insertDivision(map);
	}

	@Override
	public int updateDivision(Map map) {
		return divisionDao.updateDivision(map);
	}

	@Override
	public int deleteDivision(String division_num) {
		return divisionDao.deleteDivision(division_num);
	}

	@Override
	public int selectDivisionNum() {
		return divisionDao.selectDivisionNum();
	}

	@Override
	public int createBoardTable(int division_num) {		
		return divisionDao.createBoardTable(division_num);
	}

	@Override
	public int visibleN(String com_url) {
		return divisionDao.visibleN(com_url);
		
	}

	@Override
	public int visibleY(String division_num) {
		return divisionDao.visibleY(division_num);		
	}

}
