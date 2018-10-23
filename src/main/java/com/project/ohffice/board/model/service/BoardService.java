package com.project.ohffice.board.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.project.ohffice.board.model.vo.Board;

public interface BoardService {
	
	ArrayList<Board> boardList(String table);
	int insertBoard(Map<String, String> map);
	Board selectBoard(Map<String, String> map);
	int updateBoard(Map<String, String> map);
	int deleteBoard(Map<String, String> map);

}
