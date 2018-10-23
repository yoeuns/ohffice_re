package com.project.ohffice.document.model.vo;

public class Folder implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 734L;

	private String folder_id;
	private String com_url;
	private String folder_name;
	
	public Folder() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Folder(String folder_id, String com_url, String folder_name, String folder_parent) {
		super();
		this.folder_id = folder_id;
		this.com_url = com_url;
		this.folder_name = folder_name;

	}



	
	public String getFolder_id() {
		return folder_id;
	}



	public void setFolder_id(String folder_id) {
		this.folder_id = folder_id;
	}



	public String getCom_url() {
		return com_url;
	}



	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}



	public String getFolder_name() {
		return folder_name;
	}



	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
	}






	@Override
	public String toString() {
		return "Folder [folder_id=" + folder_id + ", com_url=" + com_url + ", folder_name=" + folder_name + "]";
	}
	
	
	
}
