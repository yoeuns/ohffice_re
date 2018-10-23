package com.project.ohffice.board.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.project.ohffice.board.model.vo.Division;

public interface DivisionService {
	ArrayList<Division> divisionList();
	int insertDivision(Map map);
	int updateDivision(Map map);
	int deleteDivision(String division_num);
	int selectDivisionNum();
	int createBoardTable(int division_num);
	int visibleN(String com_url);
	int visibleY(String division_num);
}
