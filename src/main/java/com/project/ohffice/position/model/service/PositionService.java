package com.project.ohffice.position.model.service;

import java.util.ArrayList;

import com.project.ohffice.position.model.vo.Position;

public interface PositionService {

	ArrayList<Position> posList(String com_url);

	int insertPos(Position pos);

	int updatePos(Position pos);

	int deletePos(String pos_num);

}
