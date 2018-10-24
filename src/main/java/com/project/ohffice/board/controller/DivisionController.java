package com.project.ohffice.board.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import com.project.ohffice.board.model.service.DivisionService;
import com.project.ohffice.board.model.vo.Division;
import com.project.ohffice.employee.model.vo.Employee;

@Controller
public class DivisionController {
	
	@Autowired
	private DivisionService divisionService;
	
	@RequestMapping("moveBoardSetting.do")
	public String moveBoardSettingPage() {
		return "board/boardSetting";
	}
	
	@RequestMapping(value = "divisionlist.do", method=RequestMethod.POST)
	public void memberListMethod(HttpServletResponse response) throws Exception {
		/*ArrayList list = divisionService.divisionList();
		mv.addObject("list", list);
		mv.setViewName("board/boardSetting");*/

		// 전송될 json 객체 선언 : 객체 하나만 내보낼 수 있음
		JSONObject json = new JSONObject();
		// list는 json 배열에 저장하고, json 배열을 전송용 json 객체에 저장함
		JSONArray jarr = new JSONArray();
		
		ArrayList<Division> list = divisionService.divisionList();
		
		for(Division d : list){
			JSONObject job = new JSONObject();
			job.put("division_num", d.getDivision_num());
			job.put("com_url", d.getCom_url());
			job.put("division_name", d.getDivision_name());
			job.put("auth_dept", d.getAuth_dept());
			job.put("board_visible", d.getBoard_visible());			

			jarr.add(job);
		}
		// json 배열을 전송용 json 객체에 저장함
		json.put("list", jarr);

		// json 내보내기
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(json.toJSONString());
		out.flush();
		out.close();
	}

	@RequestMapping(value="insertDivision.do", method=RequestMethod.POST)
	public void insertDivisionMethod(HttpServletResponse response, @RequestParam(value="division_name") String division_name, @RequestParam(value="com_url") String com_url) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		int num = divisionService.selectDivisionNum();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter1", division_name);
		map.put("parameter2", com_url);
		
		if(divisionService.insertDivision(map) > 0) {			
			// 게시판 생성 성공하면 해당 게시판 번호에대한 테이블 생성
			int division_num = divisionService.selectDivisionNum();
			if(divisionService.createBoardTable(division_num) >= 0) {
				out.append("ok");
				out.flush();
			}			
		} else {
			out.append("fail");
			out.flush();
		}
		out.close();
	}
	
	@RequestMapping(value="modifyDivision.do", method=RequestMethod.POST)
	public void modifyDivisionMethod(HttpServletResponse response, @RequestParam(value="newBName") String newBName, @RequestParam(value="division_num") String division_num) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("parameter1", newBName);
		map.put("parameter2", division_num);
		
		if(divisionService.updateDivision(map) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
	
	@RequestMapping(value="deleteDivision.do", method=RequestMethod.POST)
	public void deleteDivisionMethod(HttpServletResponse response, @RequestParam(value="division_num") String division_num) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(divisionService.deleteDivision(division_num) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
	
	@RequestMapping(value="boardVisible.do", method=RequestMethod.POST)
	public ResponseEntity<String> boardVisibleMethod(@RequestBody String param) throws Exception {
		
		System.out.println("param : " + param);
		
		// 전송 온 json 문자열을 json 객체로 바꿈
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		String com_url = (String)jarr.get(0);
		
		System.out.println("jarr size : " + jarr.size());
		
		divisionService.visibleN(com_url);
		for(int i = 1; i < jarr.size(); i++) {
			divisionService.visibleY((String)jarr.get(i));
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}
