package com.project.ohffice.document.model.vo;

public class Document implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 17L;
	private int doc_num;
	private String com_url;
	private String doc_id;
	private String doc_name;
	private String doc_writer;
	private String doc_approver;
	private String doc_approvers;
	private String doc_receivers;
	private String appr_status;
	private String appr_cancelYN;
	private String temp;
	private String doc_date;
	
	public Document() {
		// TODO Auto-generated constructor stub
	}
	
	public Document(int doc_num, String com_url, String doc_id, String doc_name, String doc_writer, String doc_approver,
			String doc_approvers, String doc_receivers, String appr_status, String appr_cancelYN, String temp,
			String doc_date) {
		super();
		this.doc_num = doc_num;
		this.com_url = com_url;
		this.doc_id = doc_id;
		this.doc_name = doc_name;
		this.doc_writer = doc_writer;
		this.doc_approver = doc_approver;
		this.doc_approvers = doc_approvers;
		this.doc_receivers = doc_receivers;
		this.appr_status = appr_status;
		this.appr_cancelYN = appr_cancelYN;
		this.temp = temp;
		this.doc_date = doc_date;
	}

	public int getDoc_num() {
		return doc_num;
	}

	public void setDoc_num(int doc_num) {
		this.doc_num = doc_num;
	}

	public String getCom_url() {
		return com_url;
	}

	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}

	public String getDoc_id() {
		return doc_id;
	}

	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}

	public String getDoc_name() {
		return doc_name;
	}

	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}

	public String getDoc_writer() {
		return doc_writer;
	}

	public void setDoc_writer(String doc_writer) {
		this.doc_writer = doc_writer;
	}

	public String getDoc_approver() {
		return doc_approver;
	}

	public void setDoc_approver(String doc_approver) {
		this.doc_approver = doc_approver;
	}

	public String getDoc_approvers() {
		return doc_approvers;
	}

	public void setDoc_approvers(String doc_approvers) {
		this.doc_approvers = doc_approvers;
	}

	public String getDoc_receivers() {
		return doc_receivers;
	}

	public void setDoc_receivers(String doc_receivers) {
		this.doc_receivers = doc_receivers;
	}

	public String getAppr_status() {
		return appr_status;
	}

	public void setAppr_status(String appr_status) {
		this.appr_status = appr_status;
	}

	public String getAppr_cancelYN() {
		return appr_cancelYN;
	}

	public void setAppr_cancelYN(String appr_cancelYN) {
		this.appr_cancelYN = appr_cancelYN;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public String getDoc_date() {
		return doc_date;
	}

	public void setDoc_date(String doc_date) {
		this.doc_date = doc_date;
	}

	@Override
	public String toString() {
		return "Document [doc_num=" + doc_num + ", com_url=" + com_url + ", doc_id=" + doc_id + ", doc_name=" + doc_name
				+ ", doc_writer=" + doc_writer + ", doc_approver=" + doc_approver + ", doc_approvers=" + doc_approvers
				+ ", doc_receivers=" + doc_receivers + ", appr_status=" + appr_status + ", appr_cancelYN="
				+ appr_cancelYN + ", temp=" + temp + ", doc_date=" + doc_date + "]";
	}
	
	
	
	
}
