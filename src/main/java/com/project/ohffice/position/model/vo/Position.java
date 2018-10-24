package com.project.ohffice.position.model.vo;

import java.io.Serializable;

public class Position implements Serializable {
	private static final long serialVersionUID = 10L; 
	
	private String com_url;
	private int pos_num;
	private String pos_name;
	
	public Position() {}

	public Position(String com_url, int pos_num, String pos_name) {
		super();
		this.com_url = com_url;
		this.pos_num = pos_num;
		this.pos_name = pos_name;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public int getPos_num() {
		return pos_num;
	}

	public void setPos_num(int pos_num) {
		this.pos_num = pos_num;
	}

	public String getPos_name() {
		return pos_name;
	}

	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}

	@Override
	public String toString() {
		return "Position [com_url=" + com_url + ", pos_num=" + pos_num + ", pos_name=" + pos_name + "]";
	}
	
}
