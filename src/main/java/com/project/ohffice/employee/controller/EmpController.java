package com.project.ohffice.employee.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.project.ohffice.employee.model.service.EmpService;
import com.project.ohffice.employee.model.vo.CommonInfo;
import com.project.ohffice.employee.model.vo.Employee;
import com.project.ohffice.employee.model.vo.EmployeeList;

@Controller
public class EmpController {

	@Autowired
	private EmpService empService;
		
	@RequestMapping(value = "confirmURL", method = RequestMethod.POST)
	public ResponseEntity<String> cofirmURL(@RequestBody String param, Employee emp,HttpServletRequest request) throws Exception {
		// �쟾�넚�삩 json 臾몄옄�뿴�쓣 json 媛앹껜濡� 諛붽퓞
		HttpSession session = request.getSession();
		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject) jparser.parse(param);

		String name = (String) job.get("name");
		String id = (String) job.get("id");
		String email = (String) job.get("email");
		String token = (String) job.get("token");
		String url = (String)job.get("url");
		System.out.println("name : " + name);
		System.out.println("id : " + id);
		System.out.println("email : " + email);
		System.out.println("token : " + token);
		System.out.println("url : "+ url);
		List ClientIDs = new ArrayList();
		NetHttpTransport transport = new NetHttpTransport();
		JsonFactory  mJFactory = new GsonFactory();
		GoogleIdTokenVerifier  mVerifier = new GoogleIdTokenVerifier(transport, mJFactory);
		
		ClientIDs.add(0, "587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com");
		
			// (Receive idTokenString by HTTPS POST)

			GoogleIdToken idToken = mVerifier.verify(token);
			if (idToken != null) {
			  Payload payload = idToken.getPayload();
			  if(!ClientIDs.contains(payload.getAuthorizedParty())){
				  System.out.println("missmatch");
			  }
			  // Print user identifier
			  String userId = payload.getSubject();
			  System.out.println("User ID: " + userId);

			  // Get profile information from payload
			  String email1 = payload.getEmail();
			  boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			  String name1 = (String) payload.get("name");
			  String pictureUrl = (String) payload.get("picture");
			  String locale = (String) payload.get("locale");
			  String familyName = (String) payload.get("family_name");
			  String givenName = (String) payload.get("given_name");
			  System.out.println(emailVerified);
			  // Use or store profile information
			  // ...

			} else {
			  System.out.println("Invalid ID token.");
			}
		
		emp.setEmp_name(name);
		emp.setClient_id(id);
		emp.setEmp_email(email);

		String userURL = empService.selectCompany(emp);
		url = ((Employee) session.getAttribute("loginUser")).getCom_url();
		if(userURL == null || userURL.isEmpty() || userURL.length() == 0){
			return new ResponseEntity<String>("notURL", HttpStatus.OK);
		}
		if(!userURL.equals(url)){
			return new ResponseEntity<String>("missmatch", HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public ResponseEntity<String> googleLogin(@RequestBody String param, HttpSession session, Employee emp) throws Exception {

		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject) jparser.parse(param);

		String name = (String) job.get("name");
		String id = (String) job.get("id");
		String email = (String) job.get("email");
		String token = (String) job.get("token");
		System.out.println("name : " + name);
		System.out.println("id : " + id);
		System.out.println("email : " + email);
		System.out.println("token : " + token);
		
		List ClientIDs = new ArrayList();
		NetHttpTransport transport = new NetHttpTransport();
		JsonFactory  mJFactory = new GsonFactory();
		GoogleIdTokenVerifier  mVerifier = new GoogleIdTokenVerifier(transport, mJFactory);
		
		ClientIDs.add(0, "587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com");
		
			// (Receive idTokenString by HTTPS POST)

			GoogleIdToken idToken = mVerifier.verify(token);
			if (idToken != null) {
			  Payload payload = idToken.getPayload();
			  if(!ClientIDs.contains(payload.getAuthorizedParty())){
				  System.out.println("missmatch");
			  }
			  // Print user identifier
			  String userId = payload.getSubject();
			  System.out.println("User ID: " + userId);

			  // Get profile information from payload
			  String email1 = payload.getEmail();
			  boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			  String name1 = (String) payload.get("name");
			  String pictureUrl = (String) payload.get("picture");
			  String locale = (String) payload.get("locale");
			  String familyName = (String) payload.get("family_name");
			  String givenName = (String) payload.get("given_name");
			  System.out.println(emailVerified);
			  // Use or store profile information
			  // ...

			} else {
			  System.out.println("Invalid ID token.");
			}
		
		emp.setEmp_name(name);
		emp.setClient_id(id);
		emp.setEmp_email(email);
		emp.setAuth_num(1);

		// 이미 등록된 유저 or 초대된 유저라면
		if(empService.selectEmp(email) != null){	
			session.setAttribute("loginUser", empService.selectEmp(email));
			if(empService.selectEmp(email).getClient_id() == null) {
				// 초대된 조직원이면 client_id 없기 때문에 업데이트
				empService.updateEmpId(emp);
			}
			
			if(empService.selectEmp(email).getCertification_status().equals("N")) {
				return new ResponseEntity<String>("emailCertification", HttpStatus.OK);
			}
			session.setAttribute("loginUser", empService.selectEmp(email));
			return new ResponseEntity<String>("ismember",HttpStatus.OK);
		}
		
		empService.empInsert(emp);		
		session.setAttribute("loginUser", empService.selectEmp(email));
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@RequestMapping(value = "iscompany.do", method = RequestMethod.POST)
	public ResponseEntity<String> isCompany(@RequestBody String param, Employee emp) throws Exception {
		// �쟾�넚�삩 json 臾몄옄�뿴�쓣 json 媛앹껜濡� 諛붽퓞
		
		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject) jparser.parse(param);
		
		String name = (String) job.get("name");
		String id = (String) job.get("id");
		String email = (String) job.get("email");
		
		System.out.println("name : " + name);
		System.out.println("id : " + id);
		System.out.println("email : " + email);
		
		emp.setEmp_name(name);
		emp.setClient_id(id);
		emp.setEmp_email(email);
		emp.setAuth_num(1);
		
		String url = empService.selectCompany(emp);
		
		return new ResponseEntity<String>(url, HttpStatus.OK);
	}
	
	@RequestMapping(value = "emplist.do", method=RequestMethod.GET)
	public void empListMethod(HttpServletResponse response, ModelAndView mv) throws Exception {
		// 전송될 json 객체 선언 : 객체 하나만 내보낼 수 있음
		JSONObject json = new JSONObject();
		// list는 json 배열에 저장하고, json 배열을 전송용 json 객체에 저장함
		JSONArray jarr = new JSONArray();
		
		ArrayList<EmployeeList> list = empService.empList();

		for(EmployeeList e : list){
			JSONObject job = new JSONObject();
			job.put("emp_name", e.getEmp_name());
			job.put("emp_email", e.getEmp_email());
			job.put("dept_num", e.getDept_num());		
			job.put("auth_num", e.getAuth_num());
			job.put("emp_tel", e.getEmp_tel());
			job.put("com_url", e.getCom_url());	
			job.put("dept_name", e.getDept_name());	
			job.put("auth_name", e.getAuth_name());	
			job.put("pos_name", e.getPos_name());	
			job.put("pos_num", e.getPos_num());	

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
	
	@RequestMapping(value="deleteEmp.do", method=RequestMethod.POST)
	public String deleteEmpMethod(HttpServletResponse response, @RequestParam(value="emp_email") String emp_email) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		if(empService.deleteEmp(emp_email) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
		
		return "admin/deptSetting";
	}
	
	@RequestMapping("commonInfo.do")
	public ModelAndView commonInfo(HttpServletRequest request) throws Exception{
		
		ArrayList<CommonInfo> list = empService.infoList();
		
		System.out.println("넘어온값 : " + list);
		
		ModelAndView view = new ModelAndView();
		
		view.setViewName("commonInfo/commonInfo");
		
		view.addObject("list", list);
		
		return view;
	}
	
	@RequestMapping(value="updateEmpDept.do", method=RequestMethod.POST)
	public String updateEmpDept(HttpServletResponse response, Employee emp) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(empService.updateEmpDept(emp) > 0) {
			out.append("ok");
			out.flush();
		} else {
			out.append("fail");
			out.flush();
		}		
		out.close();
		
		return "admin/deptSetting";
	}
	
	@RequestMapping(value="myInfo.do", method = RequestMethod.GET)
	   public ModelAndView myInfoMethod(ModelAndView mv, HttpServletRequest request) {
	      System.out.println("진입");
	      HttpSession session = request.getSession();
	      
	      Employee emp = (Employee) session.getAttribute("loginUser");
	      
	      System.out.println(emp);
	      
	      String email = emp.getEmp_email();
	      
	      mv.addObject("emp", empService.myInfo(email));
	      
	      System.out.println("받아온 값 : " + mv);

	      
	      return mv;
	      
	   }
	   
	   @RequestMapping(value="mChange.do", method = RequestMethod.POST)
	   public ModelAndView mChangeMethod(ModelAndView mv, @RequestParam HashMap<String, String> map, Employee emp) {
	      
	      emp.setEmp_email(map.get("email"));
	      emp.setEmp_produce(map.get("produce"));
	      emp.setEmp_addr(map.get("address"));
	      emp.setEmp_tel(map.get("phone"));
	      emp.setEmp_birth(map.get("birth"));
	      emp.setEmp_gender(map.get("gender"));
	      emp.setEmp_marriaged(map.get("marriaged"));
	      emp.setEmp_army(map.get("army"));
	      
	      
	      int result = empService.changeMyInfo(emp);
	      
	      if(result == 1) {
	         
	         mv.setViewName("myInfo");
	         
	      }
	      
	      return mv;
	      
	   }
	   
	   @RequestMapping("empInfo.do")
	   public ModelAndView empInfoMethod(ModelAndView mv, HttpServletRequest request) {
	      
	      HttpSession session = request.getSession();
	      
	      Employee emp = (Employee) session.getAttribute("loginUser");
	      
	      String comURL = emp.getCom_url();
	      
	      List<EmployeeList> list = empService.empInfo(comURL);
	      
	      mv.addObject("emp", list);
	      
	      mv.setViewName("empInfo");
	      
	      return mv;
	      
	   }
	   
	   @RequestMapping(value="selectDept.do", method=RequestMethod.POST)
	   public void selectDept(HttpServletResponse response, @RequestParam(value="dname") String dept_name) throws IOException {      
	      
	      List<EmployeeList> list = empService.selectDept(dept_name);      
	      System.out.println(list);
	      
	      JSONArray jarr = new JSONArray();
	      for(EmployeeList emp : list) {
	         
	         JSONObject juser = new JSONObject();
	         
	         juser.put("ename", emp.getEmp_name());
	         juser.put("cname", emp.getCom_name());
	         juser.put("dname", emp.getDept_name());
	         juser.put("email", emp.getEmp_email());
	         juser.put("phone", emp.getEmp_tel());

	         jarr.add(juser);
	      }
	      
	      JSONObject sendJson = new JSONObject();
	      
	      sendJson.put("list", jarr);

	      response.setContentType("application/json; charset=utf-8");
	      PrintWriter out = response.getWriter();
	      out.println(sendJson.toJSONString());
	      out.flush();
	      out.close();
	   }
	   
	   @RequestMapping(value="updateEmpPos.do", method=RequestMethod.POST)
		public String updateEmpPos(HttpServletResponse response, Employee emp) throws Exception {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(empService.updateEmpPos(emp) > 0) {
				out.append("ok");
				out.flush();
			} else {
				out.append("fail");
				out.flush();
			}		
			out.close();
			
			return "admin/deptSetting";
		}
}
