package com.project.ohffice.employee.model.vo;

public class CommonInfo implements java.io.Serializable{
	private static final long serialVersionUID = 9L;
	
	public CommonInfo(){}
	
	public String com_url;
	public String emp_name;
	public String dept_name;
	public String emp_email;
	public String emp_tel;
	public String pos_name;

	public CommonInfo(String com_url, String emp_name, String dept_name, String emp_email, String emp_tel,
			String pos_name) {
		super();
		this.com_url = com_url;
		this.emp_name = emp_name;
		this.dept_name = dept_name;
		this.emp_email = emp_email;
		this.emp_tel = emp_tel;
		this.pos_name = pos_name;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getemp_email() {
		return emp_email;
	}

	public void setemp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getEmp_tel() {
		return emp_tel;
	}

	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}

	public String getPos_name() {
		return pos_name;
	}

	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}

	@Override
	public String toString() {
		return "CommonInfo [com_url=" + com_url + ", emp_name=" + emp_name + ", dept_name=" + dept_name + ", emp_email="
				+ emp_email + ", emp_tel=" + emp_tel + ", pos_name=" + pos_name + "]";
	}
	
	
}
