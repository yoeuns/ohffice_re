package com.project.ohffice.department.model.vo;

import java.io.Serializable;

public class Department  implements Serializable {
	private static final long serialVersionUID = 4L; 
	
	private String com_url;
	private int dept_num;	
	private String dept_name;
	
	public Department() {}

	public Department(String com_url, int dept_num, String dept_name) {
		super();
		this.com_url = com_url;
		this.dept_num = dept_num;
		this.dept_name = dept_name;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}
	
	public int getDept_num() {
		return dept_num;
	}

	public void setDept_num(int dept_num) {
		this.dept_num = dept_num;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	@Override
	public String toString() {
		return "Department [com_url=" + com_url + "dept_num=" + dept_num + ", dept_name=" + dept_name + "]";
	}
	
}
