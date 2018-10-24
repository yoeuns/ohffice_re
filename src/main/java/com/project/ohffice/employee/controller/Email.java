package com.project.ohffice.employee.controller;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.ohffice.employee.model.service.EmpService;
import com.project.ohffice.employee.model.vo.Employee;

@Controller
public class Email {
	
	@Autowired
	private EmpService empService;
	
	@RequestMapping(value = "mailSender.do")
	public String mailSender(Employee emp, HttpServletResponse response, HttpServletRequest request, ModelMap mo) throws Exception, AddressException, MessagingException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(emp);
		if(emp.getEmp_email().contains("@gmail.com") == false) {
			out.append("mailerror");
			out.flush();
		} else if(emp.getEmp_email() == null || emp.getEmp_name() == null || emp.getAuth_num() == '0') {
			out.append("inputerror");
			out.flush();
		} else if(empService.selectEmp(emp.getEmp_email()) != null) {
			out.append("already");
			out.flush();
		} else {
			String random = "";
			random = String.valueOf((int) Math.floor((Math.random() * (99999 - 10000 + 1))) + 10000);
			emp.setCertification_key(random);
			if(empService.insertMyEmp(emp) > 0) {
				
				// 네이버일 경우 smtp.naver.com 을 입력합니다.
				// Google일 경우 smtp.gmail.com 을 입력합니다.
				String host = "smtp.naver.com";
				
				final String username = "goodnight_bot";       //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
				final String password = "good@3768";   //네이버 이메일 비밀번호를 입력해주세요.
				int port=465; //포트번호
				 
				// 메일 내용
				String recipient = emp.getEmp_email();    //받는 사람의 메일주소를 입력해주세요.
				String subject = "Oh!ffice 인증 메일입니다."; 	//메일 제목 입력해주세요.
				String body = "http://localhost:8888/ohffice/ohffice.do?emp_email=" + emp.getEmp_email() + "&certification_key=" + emp.getCertification_key(); //메일 내용 입력해주세요.
				 
				Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
				 
				// SMTP 서버 정보 설정
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.ssl.trust", host);
				   
				//Session 생성
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					String un=username;
					String pw=password;
					protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
						return new javax.mail.PasswordAuthentication(un, pw);
					}
				});
				session.setDebug(true); //for debug
				   
				Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
				mimeMessage.setFrom(new InternetAddress("goodnight_bot@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.
				mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
			
			
				mimeMessage.setSubject(subject);  //제목셋팅
				mimeMessage.setText(body);        //내용셋팅
				Transport.send(mimeMessage); //javax.mail.Transport.send() 이용	
				
				out.append("ok");
				out.flush();
			} else {
				out.append("fail");
				out.flush();
			}
		} 
			
		out.close();

		return "admin/deptSetting";
	}
	
	@RequestMapping(value = "ohffice.do")
	public ModelAndView mailCheck(Employee emp, HttpServletResponse response, ModelAndView mv) throws Exception {
		response.setContentType("text/html; charset=UTF-8");

		if(empService.updateCertification(emp) > 0) {
			mv.addObject("emailResult", "ok");
		}
		else {
			mv.addObject("emailResult", "fail");
		}
		mv.setViewName("emailCertification");
		
		return mv;
	}
}
