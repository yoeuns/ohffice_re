package com.project.ohffice.board.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.board.model.service.BoardService;
import com.project.ohffice.board.model.vo.Board;
import com.project.ohffice.employee.model.vo.Employee;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("moveBoard.do")
	public ModelAndView moveBoardPage(HttpServletRequest request) {  
    	
    	String division_num = "0"; 
    	
    	ModelAndView view = new ModelAndView();
    	view.setViewName("board/boardList");
    	
    	view.addObject("division_num", division_num);
    	
		return view;
	}
	
    @RequestMapping("moveBoardList.do")
	public ModelAndView moveBoardListPage(HttpServletRequest request) {  
    	
    	String division_num = request.getParameter("division_num"); 
    	
    	ModelAndView view = new ModelAndView();
    	view.setViewName("board/boardList");
    	
    	view.addObject("division_num", division_num);
    	
		return view;
	}
    
    @RequestMapping(value = "boardBasic.do", method=RequestMethod.POST)
	public void basicListMethod(HttpServletRequest request,HttpServletResponse response,
     @RequestParam(value="com_url") String com_url) throws Exception {
		
	    JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		String table = "board" + com_url;
		
		SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
		ArrayList<Board> list = boardService.boardList(table);
		
		for(Board b : list){
			JSONObject job = new JSONObject();
			job.put("board_num", Integer.toString(b.getBoard_num()));
			job.put("com_url", b.getCom_url());
			job.put("board_email", b.getBoard_email());
			job.put("division_num", Integer.toString(b.getDivision_num()));
			job.put("board_title", b.getBoard_title());		
			job.put("board_content", b.getBoard_content());	
			job.put("board_date", format.format(b.getBoard_date()));	
			job.put("board_count", Integer.toString(b.getBoard_count()));	
			
			jarr.add(job);
		}
		json.put("list", jarr);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(json.toJSONString());
		out.flush();
		out.close();
	}
    

	@RequestMapping(value = "boardList.do", method=RequestMethod.POST)
	public void boardListMethod(HttpServletRequest request,HttpServletResponse response,
     @RequestParam(value="division_num") String division_num) throws Exception {
		
	    JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		String table = "board" + division_num;
		
		SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
		ArrayList<Board> list = boardService.boardList(table);
		
		for(Board b : list){
			JSONObject job = new JSONObject();
			job.put("board_num", Integer.toString(b.getBoard_num()));
			job.put("com_url", b.getCom_url());
			job.put("board_email", b.getBoard_email());
			job.put("division_num", Integer.toString(b.getDivision_num()));
			job.put("board_title", b.getBoard_title());		
			job.put("board_content", b.getBoard_content());	
			job.put("board_date", format.format(b.getBoard_date()));	
			job.put("board_count", Integer.toString(b.getBoard_count()));	
			
			jarr.add(job);
		}
		json.put("list", jarr);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(json.toJSONString());
		out.flush();
		out.close();
	}
	
	@RequestMapping(value="insertBoard.do", method=RequestMethod.POST)
	public void insertBoardMethod(HttpServletResponse response, 
			@RequestParam(value="division_num") String division_num, 
			@RequestParam(value="com_url") String com_url,
			@RequestParam(value="emp_email") String emp_email,
			@RequestParam(value="board_title") String board_title,
			@RequestParam(value="board_content") String board_content
			) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
	      map.put("param1", division_num);
	      map.put("param2", com_url);
	      map.put("param3", emp_email);
	      map.put("param4", board_title);
	      map.put("param5", board_content);
		
		if(boardService.insertBoard(map) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
	
	}
	
	@RequestMapping(value="updateBoard.do", method=RequestMethod.POST)
	public void updateBoardMethod(HttpServletResponse response, 
			@RequestParam(value="division_num") String division_num, 
			@RequestParam(value="board_num") String board_num,
			@RequestParam(value="board_title") String board_title,
			@RequestParam(value="board_content") String board_content,
			@RequestParam(value="com_url") String com_url
			) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("param1", division_num);
		map.put("param2", board_num);
		map.put("param3", board_title);
		map.put("param4", board_content);
		map.put("param5", com_url);
		
		if(boardService.updateBoard(map) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
	
	}
	
	@RequestMapping(value="deleteBoard.do", method=RequestMethod.POST)
	public void deleteBoardMethod(HttpServletResponse response, 
			@RequestParam(value="division_num") String division_num, 
			@RequestParam(value="board_num") String board_num,
			@RequestParam(value="com_url") String com_url
			) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("param1", division_num);
		map.put("param2", board_num);
		map.put("param3", com_url);
		
		if(boardService.deleteBoard(map) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
	
	}
	
	@RequestMapping(value = "boardSelect.do", method = RequestMethod.POST)
	public void selectBoard(HttpServletResponse response,@RequestParam(value="board_num") String board_num, 
			@RequestParam(value="division_num") String division_num,
			@RequestParam(value="com_url") String com_url) throws Exception {
		
		JSONObject json = new JSONObject();
		JSONArray jarr = new JSONArray();
		
	    Map<String, String> map = new HashMap<String, String>();
		map.put("param1", division_num);
		map.put("param2", board_num);
		map.put("param3", com_url);
		
		SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
		Board board = boardService.selectBoard(map);
		
			JSONObject job = new JSONObject();
			job.put("board_num", Integer.toString(board.getBoard_num()));
			job.put("com_url", board.getCom_url());
			job.put("board_email", board.getBoard_email());
			job.put("division_num", Integer.toString(board.getDivision_num()));
			job.put("board_title", board.getBoard_title());		
			job.put("board_content", board.getBoard_content());	
			job.put("board_date", format.format(board.getBoard_date()));	
			job.put("board_count", Integer.toString(board.getBoard_count()));	
			
			jarr.add(job);
			
		json.put("list", jarr);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(json.toJSONString());
		out.flush();
		out.close();
		
	}
	
	
}
