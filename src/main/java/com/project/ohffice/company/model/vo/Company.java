package com.project.ohffice.company.model.vo;

public class Company implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;
	
	private String com_url;
	private String emp_email;
	private String com_name;
	private String com_tel;
	private String com_logo;
	private String com_addr;
	
	public Company() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Company(int com_num, String emp_email, String com_name, String com_url, String com_tel, String com_logo, String com_addr) {
		super();

		this.emp_email = emp_email;
		this.com_name = com_name;
		this.com_url = com_url;
		this.com_tel = com_tel;
		this.com_logo = com_logo;
		this.com_addr = com_addr;
	}




	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getCom_name() {
		return com_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getCom_tel() {
		return com_tel;
	}

	public void setCom_tel(String com_tel) {
		this.com_tel = com_tel;
	}

	public String getCom_logo() {
		return com_logo;
	}

	public void setCom_logo(String com_logo) {
		this.com_logo = com_logo;
	}
	
	public String getCom_addr() {
		return com_addr;
	}

	public void setCom_addr(String com_addr) {
		this.com_addr = com_addr;
	}



	@Override
	public String toString() {
		return "Company [ emp_email=" + emp_email + ", com_name=" + com_name + ", com_url="
				+ com_url + ", com_tel=" + com_tel + ", com_logo=" + com_logo + ", com_addr=" + com_addr + "]";
	}

	

}
