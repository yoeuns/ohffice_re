package com.project.ohffice.authority.model.vo;

import java.io.Serializable;

public class Authority implements Serializable {
	private static final long serialVersionUID = 5L;
	
	private int auth_num;
	private String com_url;
	private String auth_name;
	
	public Authority() {}

	public Authority(int auth_num, String com_url, String auth_name) {
		super();
		this.auth_num = auth_num;
		this.com_url = com_url;
		this.auth_name = auth_name;
	}

	public int getAuth_num() {
		return auth_num;
	}

	public void setAuth_num(int auth_num) {
		this.auth_num = auth_num;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getAuth_name() {
		return auth_name;
	}

	public void setAuth_name(String auth_name) {
		this.auth_name = auth_name;
	}

	@Override
	public String toString() {
		return "Authority [auth_num=" + auth_num + ", com_url=" + com_url + ", auth_name=" + auth_name + "]";
	}
	
}
