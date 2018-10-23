package com.project.ohffice.board.model.vo;

import java.io.Serializable;

public class Division implements Serializable {
	private static final long serialVersionUID = 3L; 
	
	private int division_num;
	private String com_url;
	private String division_name;
	private String auth_dept;
	private String board_visible;
	
	public Division() {}

	public Division(int division_num, String com_url, String division_name, String auth_dept, String board_visible) {
		super();
		this.division_num = division_num;
		this.com_url = com_url;
		this.division_name = division_name;
		this.auth_dept = auth_dept;
		this.board_visible = board_visible;
	}

	public int getDivision_num() {
		return division_num;
	}

	public void setDivision_num(int division_num) {
		this.division_num = division_num;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getDivision_name() {
		return division_name;
	}

	public void setDivision_name(String division_name) {
		this.division_name = division_name;
	}

	public String getAuth_dept() {
		return auth_dept;
	}

	public void setAuth_dept(String auth_dept) {
		this.auth_dept = auth_dept;
	}

	public String getBoard_visible() {
		return board_visible;
	}

	public void setBoard_visible(String board_visible) {
		this.board_visible = board_visible;
	}

	@Override
	public String toString() {
		return "Division [division_num=" + division_num + ", com_url=" + com_url + ", division_name=" + division_name
				+ ", auth_dept=" + auth_dept + ", board_visible=" + board_visible + "]";
	}
	
}
