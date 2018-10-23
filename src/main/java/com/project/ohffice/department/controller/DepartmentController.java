package com.project.ohffice.department.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.department.model.service.DepartmentService;
import com.project.ohffice.department.model.vo.Department;

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("moveDeptSetting.do")
	public String moveDeptSettingPage() {
		return "admin/deptSetting";
	}
	
	@RequestMapping(value = "deptlist.do", method=RequestMethod.GET)
	public void deptListMethod(HttpServletResponse response, ModelAndView mv) throws Exception {
		/*ArrayList<Department> list = departmentService.departmentList();
		mv.addObject("deptList", list);
		mv.setViewName("board/boardSetting");*/

		// 전송될 json 객체 선언 : 객체 하나만 내보낼 수 있음
		JSONObject json = new JSONObject();
		// list는 json 배열에 저장하고, json 배열을 전송용 json 객체에 저장함
		JSONArray jarr = new JSONArray();
		
		ArrayList<Department> list = departmentService.departmentList();
		
		for(Department d : list){
			JSONObject job = new JSONObject();
			job.put("com_url", d.getCom_url());
			job.put("dept_num", d.getDept_num());
			job.put("dept_name", d.getDept_name());

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
	
	@RequestMapping(value="insertDept.do", method=RequestMethod.POST)
	public void insertDeptMethod(HttpServletResponse response, @RequestParam(value="dept_name") String dept_name, @RequestParam(value="com_url") String com_url) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("dept_name", dept_name);
		map.put("com_url", com_url);
		
		if(departmentService.insertDept(map) > 0) {			
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}
		out.close();
	}
	
	@RequestMapping(value="modifyDept.do", method=RequestMethod.POST)
	public void modifyDeptMethod(HttpServletResponse response, @RequestParam(value="newDName") String newDName, @RequestParam(value="dept_num") String dept_num) throws Exception {
		// 클라이언트의 출력스트림 만들기
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("newDName", newDName);
		map.put("dept_num", dept_num);
		
		if(departmentService.updateDept(map) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
	
	@RequestMapping(value="deleteDept.do", method=RequestMethod.POST)
	public void deleteDeptMethod(HttpServletResponse response, @RequestParam(value="dept_num") String dept_num) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println("dddddddddddddd??????????????????????????");
		if(departmentService.deleteDept(dept_num) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
	}
}
