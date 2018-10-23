package com.project.ohffice.authority.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.authority.model.service.AuthorityService;
import com.project.ohffice.authority.model.vo.Authority;
import com.project.ohffice.department.model.vo.Department;

@Controller
public class AuthorityController {
	
	@Autowired
	private AuthorityService authService;
	
	/*@RequestMapping("moveAuthSetting.do")
	public String moveAuthSettingPage() {
		return "admin/authSetting";
	}*/
	
	@RequestMapping(value = "authlist.do", method=RequestMethod.GET)
	public void authListMethod(HttpServletResponse response, ModelAndView mv) throws Exception {
		// 전송될 json 객체 선언 : 객체 하나만 내보낼 수 있음
		JSONObject json = new JSONObject();
		// list는 json 배열에 저장하고, json 배열을 전송용 json 객체에 저장함
		JSONArray jarr = new JSONArray();
		
		ArrayList<Authority> list = authService.authList();
		
		for(Authority d : list){
			JSONObject job = new JSONObject();
			job.put("com_url", d.getCom_url());
			job.put("auth_num", d.getAuth_num());
			job.put("auth_name", d.getAuth_name());

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
	
}
