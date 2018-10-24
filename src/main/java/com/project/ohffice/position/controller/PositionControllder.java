package com.project.ohffice.position.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.ohffice.position.model.service.PositionService;
import com.project.ohffice.position.model.vo.Position;

@Controller
public class PositionControllder {
	@Autowired
	private PositionService posService;
	
	@RequestMapping("movePosSetting.do")
	public String movePosSetting() {
		return "admin/posSetting";
	}
	
	@RequestMapping(value="posList.do", method=RequestMethod.POST)
	public void posListMethod(HttpServletResponse response, @RequestParam(value="com_url") String com_url) throws Exception {
		// 전송될 json 객체 선언 : 객체 하나만 내보낼 수 있음
		JSONObject json = new JSONObject();
		// list는 json 배열에 저장하고, json 배열을 전송용 json 객체에 저장함
		JSONArray jarr = new JSONArray();
		
		ArrayList<Position> list = posService.posList(com_url);
		
		for(Position p : list){
			JSONObject job = new JSONObject();
			job.put("pos_num", p.getPos_num());
			job.put("com_url", p.getCom_url());
			job.put("pos_name", p.getPos_name());	

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
	
	@RequestMapping(value="insertPos.do", method=RequestMethod.POST)
	public void insertPosMethod(HttpServletResponse response, Position pos) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(posService.insertPos(pos) > 0) {				
			out.append("ok");
			out.flush();		
		} else {
			out.append("fail");
			out.flush();
		}
		out.close();
	}
	
	@RequestMapping(value="modifyPos.do", method=RequestMethod.POST)
	public void modifyPosMethod(HttpServletResponse response, Position pos) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(posService.updatePos(pos) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
	
	@RequestMapping(value="deletePos.do", method=RequestMethod.POST)
	public void deletePosMethod(HttpServletResponse response, @RequestParam(value="pos_num") String pos_num) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(posService.deletePos(pos_num) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
}
