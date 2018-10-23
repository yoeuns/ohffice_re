package com.project.ohffice.board.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.board.model.dao.BoardDao;
import com.project.ohffice.board.model.vo.Board;
import com.project.ohffice.employee.model.vo.Employee;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	public BoardServiceImpl() {}

	@Override
	public ArrayList<Board> boardList(String table) {
		return boardDao.boardList(table);
	}
	
	@Override
	public int insertBoard(Map map) {
		return boardDao.insertBoard(map);
	}
	
	@Override
	public int updateBoard(Map map) {
		return boardDao.updateBoard(map);
	}
	
	@Override
	public int deleteBoard(Map map) {
		return boardDao.deleteBoard(map);
	}
	
	@Override
	public Board selectBoard(Map<String, String> map) {
		return boardDao.selectBoard(map);
    }


}
