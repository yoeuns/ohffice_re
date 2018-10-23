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
            
            // ���̹��� ��� smtp.naver.com �� �Է��մϴ�.
            // Google�� ��� smtp.gmail.com �� �Է��մϴ�.
            String host = "smtp.naver.com";
            
            final String username = "goodnight_bot";       //���̹� ���̵� �Է����ּ���. @nave.com�� �Է����� ���ñ���.
            final String password = "good@3768";   //���̹� �̸��� ��й�ȣ�� �Է����ּ���.
            int port=465; //��Ʈ��ȣ
             
            // ���� ����
            String recipient = emp.getEmp_email();    //�޴� ����� �����ּҸ� �Է����ּ���.
            String subject = "Oh!ffice ���� �����Դϴ�.";    //���� ���� �Է����ּ���.
            String body = "http://localhost:8888/ohffice/ohffice.do?emp_email=" + emp.getEmp_email() + "&certification_key=" + emp.getCertification_key(); //���� ���� �Է����ּ���.
             
            Properties props = System.getProperties(); // ������ ��� ���� ��ü ����
             
            // SMTP ���� ���� ����
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.trust", host);
               
            //Session ����
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
               String un=username;
               String pw=password;
               protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                  return new javax.mail.PasswordAuthentication(un, pw);
               }
            });
            session.setDebug(true); //for debug
               
            Message mimeMessage = new MimeMessage(session); //MimeMessage ����
            mimeMessage.setFrom(new InternetAddress("goodnight_bot@naver.com")); //�߽��� ���� , ������ ����� �̸����ּҸ� �ѹ� �� �Է��մϴ�. �̶��� �̸��� Ǯ �ּҸ� �� �ۼ����ּ���.
            mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //�����ڼ��� //.TO �ܿ� .CC(����) .BCC(��������) �� ����
         
         
            mimeMessage.setSubject(subject);  //�������
            mimeMessage.setText(body);        //�������
            Transport.send(mimeMessage); //javax.mail.Transport.send() �̿�   
            
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