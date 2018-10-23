package com.project.ohffice.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable {
	private static final long serialVersionUID = 2L; 
	
	private int board_num;
	private String com_url;
	private String board_email;
	private int division_num;
	private String board_title;
	private String board_content;
	private Date board_date;
	private int board_count;
	
	public Board() {}

	public Board(int board_num, String com_url, String board_email, int division_num, String board_title,
			String board_content, Date board_date, int board_count) {
		super();
		this.board_num = board_num;
		this.com_url = com_url;
		this.board_email = board_email;
		this.division_num = division_num;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_date = board_date;
		this.board_count = board_count;
	}

	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getBoard_email() {
		return board_email;
	}

	public void setBoard_email(String board_email) {
		this.board_email = board_email;
	}

	public int getDivision_num() {
		return division_num;
	}

	public void setDivision_num(int division_num) {
		this.division_num = division_num;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}

	public int getBoard_count() {
		return board_count;
	}

	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Board [board_num=" + board_num + ", com_url=" + com_url + ", board_email=" + board_email
				+ ", division_num=" + division_num + ", board_title=" + board_title + ", board_content=" + board_content
				+ ", board_date=" + board_date + ", board_count=" + board_count + "]";
	}


	
}
