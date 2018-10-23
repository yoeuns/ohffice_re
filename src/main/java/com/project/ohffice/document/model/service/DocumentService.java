package com.project.ohffice.document.model.service;

import java.util.ArrayList;
import java.util.List;

import com.project.ohffice.company.model.vo.Company;
import com.project.ohffice.document.model.vo.Document;
import com.project.ohffice.document.model.vo.Folder;

public interface DocumentService {

	int insertFolder(Folder folder);

	String selectFolder(Folder folder);

	ArrayList<Object> selectFolders(String url);

	int insertDocument(Document doc);

	List<Document> selectDraftList(String type);

	Document selectDocument(String doc_num);

	String searchFolderId(Company com);
	
}
