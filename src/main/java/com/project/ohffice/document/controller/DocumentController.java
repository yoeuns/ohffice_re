package com.project.ohffice.document.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.company.model.service.CompanyService;
import com.project.ohffice.company.model.vo.Company;
import com.project.ohffice.document.model.service.DocumentService;
import com.project.ohffice.document.model.vo.Document;
import com.project.ohffice.document.model.vo.Folder;
import com.project.ohffice.employee.model.vo.Employee;

import net.sf.json.JSONArray;

@Controller
public class DocumentController {
	
	
	@Autowired
	private DocumentService documentService;
	
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping("documentForm.do")
	private ModelAndView documentForm(ModelAndView mv, HttpServletRequest request){
		HttpSession session = request.getSession();
		
		String url = ((Employee)session.getAttribute("loginUser")).getCom_url();
		
		ArrayList<Object> list = documentService.selectFolders(url);
		
		
		
		System.out.println(list);
		
		mv.addObject("FolderList",list);
		
		mv.setViewName("document/documentForm");
		
		return mv;
	}
	
	@RequestMapping(value = "insertFolders.do" , method = RequestMethod.POST)
	private ResponseEntity<String> insertFolder(@RequestBody String param ) throws ParseException{
		JSONParser jparser = new JSONParser();
		JSONObject job = (JSONObject) jparser.parse(param);
		Set<String> set  = job.keySet();
		String url = (String) job.get("url");
		Iterator<String> siter = set.iterator();
		
		while(siter.hasNext()){
			String key = String.valueOf(siter.next());
			if(!key.equals("url")){
				String value = (String)job.get(key);
				Folder folder = new Folder();
				folder.setFolder_id(value);
				folder.setFolder_name(key);
				folder.setCom_url(url);
				if(documentService.insertFolder(folder) < 0){
					 System.out.println("폴더 적재 실패");
				 }
			}
			
			
		}
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
		@RequestMapping(value = "selectFolder.do" , method = RequestMethod.POST)
		private ResponseEntity<String> selectFolder(Folder folder){
			String folder_id = documentService.selectFolder(folder);
			if(folder_id == null || folder_id.length() == 0 ){
				return new ResponseEntity<String>("missMatch",HttpStatus.OK);
			}
			return new ResponseEntity<String>(folder_id,HttpStatus.OK);
	}
		
		@RequestMapping(value = "insertDocument", method = RequestMethod.POST)
		public ResponseEntity<String> cofirmURL(@RequestBody String param,Document doc)
				throws Exception {
			// 전송온 json 문자열을 json 객체로 바꿈

			JSONParser jparser = new JSONParser();
			JSONObject job = (JSONObject) jparser.parse(param);

			String com_url = (String) job.get("com_url");
			String doc_id = (String) job.get("doc_id");
			String doc_name = (String) job.get("doc_name");
			String doc_writer = (String) job.get("doc_writer");
			String doc_approvers = (String) job.get("doc_approvers");
			String doc_receivers = (String)job.get("doc_receivers");
			
			String[] split = doc_approvers.split(",");
			
			String doc_approver = split[0];
			
			doc.setDoc_approver(doc_approver);
			doc.setCom_url(com_url);
			doc.setDoc_approvers(doc_approvers);
			doc.setDoc_name(doc_name);
			doc.setDoc_id(doc_id);
			doc.setDoc_writer(doc_writer);
			doc.setDoc_receivers(doc_receivers);
			
			System.out.println(doc);
			
			if(documentService.insertDocument(doc) < 0){
				return new ResponseEntity<String>("fail",HttpStatus.OK);
			}
			
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		
		@RequestMapping("draftDoc.do")
		private String draftDoc(){
			
			return "document/draftDoc";
		}
		@RequestMapping("draftList.do")
		private void selectDraftList(HttpServletRequest request,HttpServletResponse response) throws IOException{
			
			String email = request.getParameter("email1");
			
			List<Document> list = documentService.selectDraftList(email);
			System.out.println(list);
			
			JSONArray jarr = new JSONArray();
			for (Document doc : list) {

				JSONObject juser = new JSONObject();

				juser.put("doc_num", doc.getDoc_num());
				juser.put("doc_name", doc.getDoc_name());
				juser.put("doc_writer", doc.getDoc_writer());
				juser.put("doc_date", doc.getDoc_date());
				if(doc.getAppr_cancelYN() == "Y"){
					juser.put("doc_con", "반려");
				}else{
					juser.put("doc_con", "결재 진행중");
				}
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
		
		@RequestMapping("selectDocument.do")
		private void selectDocument(HttpServletRequest request,HttpServletResponse response) throws IOException{
			
			String doc_num = request.getParameter("doc_num");
			
			Document doc = documentService.selectDocument(doc_num);
			System.out.println(doc);
			
		/*	JSONArray jarr = new JSONArray();
			for (Document doc : list) {

				JSONObject juser = new JSONObject();

				juser.put("doc_num", doc.getDoc_num());
				juser.put("doc_name", doc.getDoc_name());
				juser.put("doc_writer", doc.getDoc_writer());
				juser.put("doc_date", doc.getDoc_date());
				if(doc.getAppr_cancelYN() == "Y"){
					juser.put("doc_con", "반려");
				}else{
					juser.put("doc_con", "결재 진행중");
				}
				jarr.add(juser);
			}

			JSONObject sendJson = new JSONObject();

			sendJson.put("list", jarr);

			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(sendJson.toJSONString());
			out.flush();
			out.close();*/
			
		}
		
		@RequestMapping(value="sharedDrive.do", method = RequestMethod.POST)
		private void sharedDriveMethod(HttpServletResponse response, Company com) throws IOException{			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			com.setCom_name(companyService.comName(com.getCom_url()));
					
			String folder_id = documentService.searchFolderId(com);

			out.append(folder_id);	
			
			out.flush();
			out.close();			
		}
		
		
}
