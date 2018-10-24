package com.project.ohffice.company.controller;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.company.model.service.CompanyService;
import com.project.ohffice.company.model.vo.Company;
import com.project.ohffice.employee.model.service.EmpService;
import com.project.ohffice.employee.model.vo.Employee;

@Controller
public class CompanyController {

	@Autowired
	private CompanyService companyService;
	@Autowired
	private EmpService empService;

	@RequestMapping(value = "comp.do", method = RequestMethod.POST)
	private ModelAndView insertCompany(Company comp, ModelAndView mv,HashMap map,HttpSession session){
		
		System.out.println(comp);
		map.put("com_url", comp.getCom_url());
		map.put("emp_email", comp.getEmp_email());
		if( companyService.insertComp(comp)>0){
			empService.updateCompanyEmployee(map);
			companyService.createBoard(map);
			mv.addObject("company",comp);
			session.setAttribute("loginUser", empService.selectEmp(comp.getEmp_email()));
			mv.setViewName("loading");
	}else{
			
			System.out.println("생성실패");
		}
		return mv;
	}

	@RequestMapping(value = "company")
	private ModelAndView showCompany(ModelAndView mv) {
		mv.setViewName("menu/main");
		return mv;

	}

	@RequestMapping(value ="comName.do", method=RequestMethod.GET)
	private void comName(HttpServletResponse response, @RequestParam(value="com_url") String com_url) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String com_name = companyService.comName(com_url);
		out.append(com_name);
		out.flush();
		out.close();
	}


	@RequestMapping(value="comManage.do", method = RequestMethod.GET)
	public ModelAndView comManageMethod(ModelAndView mv, HttpServletRequest request) {

		HttpSession session = request.getSession();

		Employee emp = (Employee) session.getAttribute("loginUser");

		String comURL = emp.getCom_url();

		System.out.println("세션 url : " + comURL);

		mv.addObject("com", companyService.comInfo(comURL));

		System.out.println("받아온 값 : " + mv);

		return mv;
	}
	
	@RequestMapping(value="comChange.do", method=RequestMethod.POST)
	public ModelAndView comChangeMethod(ModelAndView mv, @RequestParam HashMap<String, String> map, Company com) {
		
		com.setCom_name(map.get("name"));
		com.setCom_url(map.get("url"));
		com.setCom_tel(map.get("phone"));
		com.setCom_addr(map.get("address"));
		
		int result = companyService.comChangeMethod(com);
		
		if(result == 1) {
			
			mv.setViewName("comManage");
			
		}
				
		return mv;
		
	}
	
	@RequestMapping(value="infoCom.do", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject infoCom(HttpServletResponse response, HttpServletRequest request) {
		
		response.setContentType("application/json; charset=utf-8");

		HttpSession session = request.getSession();

		Employee emp = (Employee) session.getAttribute("loginUser");

		String comURL = emp.getCom_url();
		
		Company com = companyService.infoCom(comURL);
		
		JSONObject job = new JSONObject();
		job.put("name", com.getCom_name());
		job.put("tel", com.getCom_tel());
		job.put("addr", com.getCom_addr());

		return job;

	}

}
