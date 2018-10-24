package com.project.ohffice.employee.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class EmployeeList implements Serializable {

	private static final long serialVersionUID = 6L;
	
	private String emp_email;
	private String emp_name;
	private Integer auth_num;
	private Integer dept_num;
	private String emp_tel;
	private String com_url;
	private String dept_name;
	private String auth_name;
	private Integer pos_num;
	private String pos_name;
	private String com_name;
	
	public EmployeeList() {}

	public EmployeeList(String emp_email, String emp_name, Integer auth_num, Integer dept_num, String emp_tel,
			String com_url, String dept_name, String auth_name, Integer pos_num, String pos_name, String com_name) {
		super();
		this.emp_email = emp_email;
		this.emp_name = emp_name;
		this.auth_num = auth_num;
		this.dept_num = dept_num;
		this.emp_tel = emp_tel;
		this.com_url = com_url;
		this.dept_name = dept_name;
		this.auth_name = auth_name;
		this.pos_num = pos_num;
		this.pos_name = pos_name;
		this.com_name = com_name;
	}



	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public Integer getAuth_num() {
		return auth_num;
	}

	public void setAuth_num(Integer auth_num) {
		this.auth_num = auth_num;
	}

	public Integer getDept_num() {
		return dept_num;
	}

	public void setDept_num(Integer dept_num) {
		this.dept_num = dept_num;
	}

	public String getEmp_tel() {
		return emp_tel;
	}

	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getAuth_name() {
		return auth_name;
	}

	public void setAuth_name(String auth_name) {
		this.auth_name = auth_name;
	}
	
	public String getCom_name() {
		return com_name;
	}

	public Integer getPos_num() {
		return pos_num;
	}

	public void setPos_num(Integer pos_num) {
		this.pos_num = pos_num;
	}

	public String getPos_name() {
		return pos_name;
	}

	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	@Override
	public String toString() {
		return "EmployeeList [emp_email=" + emp_email + ", emp_name=" + emp_name + ", auth_num=" + auth_num
				+ ", dept_num=" + dept_num + ", emp_tel=" + emp_tel + ", com_url=" + com_url + ", dept_name="
				+ dept_name + ", auth_name=" + auth_name + ", com_name=" + com_name + "]";
	}
	
}
