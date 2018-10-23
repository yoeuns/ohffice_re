package com.project.ohffice.employee.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Employee implements Serializable {


	private static final long serialVersionUID = 1L;

	private String emp_email;
	private String client_id;
	private String emp_name;
	private Integer auth_num;
	private Integer dept_num;
	private Integer pos_num;
	private Date emp_date;
	private String emp_tel;
	private String emp_addr;
	private String emp_birth;
	private String emp_gender;
	private String emp_pic;
	private String emp_produce;
	private String emp_marriaged;
	private String emp_army;
	private Integer vac_num;
	private String emp_sign;
	private String com_url;
	private String certification_status;
	private String certification_key;
	
	public Employee(){}

	public Employee(String emp_email, String client_id, String emp_name, Integer auth_num, Integer dept_num, Integer pos_num,
			Date emp_date, String emp_tel, String emp_addr, String emp_birth, String emp_gender, String emp_pic,
			String emp_produce, String emp_marriaged, String emp_army, Integer vac_num, String emp_sign, String com_url,
			String certification_status, String certification_key) {
		super();
		this.emp_email = emp_email;
		this.client_id = client_id;
		this.emp_name = emp_name;
		this.auth_num = auth_num;
		this.dept_num = dept_num;
		this.pos_num = pos_num;
		this.emp_date = emp_date;
		this.emp_tel = emp_tel;
		this.emp_addr = emp_addr;
		this.emp_birth = emp_birth;
		this.emp_gender = emp_gender;
		this.emp_pic = emp_pic;
		this.emp_produce = emp_produce;
		this.emp_marriaged = emp_marriaged;
		this.emp_army = emp_army;
		this.vac_num = vac_num;
		this.emp_sign = emp_sign;
		this.com_url = com_url;
		this.certification_status = certification_status;
		this.certification_key = certification_key;
	}

	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getClient_id() {
		return client_id;
	}

	public void setClient_id(String client_id) {
		this.client_id = client_id;
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

	public Integer getPos_num() {
		return pos_num;
	}

	public void setPos_num(Integer pos_num) {
		this.pos_num = pos_num;
	}

	public Date getEmp_Date() {
		return emp_date;
	}

	public void setDate(Date emp_date) {
		this.emp_date = emp_date;
	}

	public String getEmp_tel() {
		return emp_tel;
	}

	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}

	public String getEmp_addr() {
		return emp_addr;
	}

	public void setEmp_addr(String emp_addr) {
		this.emp_addr = emp_addr;
	}

	public String getEmp_birth() {
		return emp_birth;
	}

	public void setEmp_birth(String emp_birth) {
		this.emp_birth = emp_birth;
	}

	public String getEmp_gender() {
		return emp_gender;
	}

	public void setEmp_gender(String emp_gender) {
		this.emp_gender = emp_gender;
	}

	public String getEmp_pic() {
		return emp_pic;
	}

	public void setEmp_pic(String emp_pic) {
		this.emp_pic = emp_pic;
	}

	public String getEmp_produce() {
		return emp_produce;
	}

	public void setEmp_produce(String emp_produce) {
		this.emp_produce = emp_produce;
	}

	public String getEmp_marriaged() {
		return emp_marriaged;
	}

	public void setEmp_marriaged(String emp_marriaged) {
		this.emp_marriaged = emp_marriaged;
	}

	public String getEmp_army() {
		return emp_army;
	}

	public void setEmp_army(String emp_army) {
		this.emp_army = emp_army;
	}

	public Integer getVac_num() {
		return vac_num;
	}

	public void setVac_num(Integer vac_num) {
		this.vac_num = vac_num;
	}

	public String getEmp_sign() {
		return emp_sign;
	}

	public void setEmp_sign(String emp_sign) {
		this.emp_sign = emp_sign;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getCertification_status() {
		return certification_status;
	}

	public void setCertification_status(String certification_status) {
		this.certification_status = certification_status;
	}

	public String getCertification_key() {
		return certification_key;
	}

	public void setCertification_key(String certification_key) {
		this.certification_key = certification_key;
	}

	@Override
	public String toString() {
		return "Employee [emp_email=" + emp_email + ", client_id=" + client_id + ", emp_name=" + emp_name
				+ ", auth_num=" + auth_num + ", dept_num=" + dept_num + ", pos_num=" + pos_num + ", emp_date=" + emp_date
				+ ", emp_tel=" + emp_tel + ", emp_addr=" + emp_addr + ", emp_birth=" + emp_birth + ", emp_gender="
				+ emp_gender + ", emp_pic=" + emp_pic + ", emp_produce=" + emp_produce + ", emp_marriaged="
				+ emp_marriaged + ", emp_army=" + emp_army + ", vac_num=" + vac_num + ", emp_sign=" + emp_sign
				+ ", com_url=" + com_url + ", certification_status=" + certification_status + ", certification_key="
				+ certification_key + "]";
	}

	

}