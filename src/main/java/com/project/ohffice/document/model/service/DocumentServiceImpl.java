package com.project.ohffice.document.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.company.model.vo.Company;
import com.project.ohffice.document.model.dao.DocumentDao;
import com.project.ohffice.document.model.vo.Document;
import com.project.ohffice.document.model.vo.Folder;

@Service("documentService")
public class DocumentServiceImpl implements DocumentService {

	@Autowired
	private DocumentDao documentDao;
	
	@Override
	public int insertFolder(Folder folder) {
		
		return documentDao.insertFolder(folder);
	}

	@Override
	public String selectFolder(Folder folder) {
		// TODO Auto-generated method stub
		return documentDao.selectFolder(folder);
	}

	@Override
	public ArrayList<Object> selectFolders(String url) {
		return documentDao.selectFolders(url);
	}

	@Override
	public int insertDocument(Document doc) {
		// TODO Auto-generated method stub
		return documentDao.insertDocument(doc);
	}

	@Override
	public List<Document> selectDraftList(String email) {
		// TODO Auto-generated method stub
		return documentDao.selectDraftList(email);
	}

	@Override
	public Document selectDocument(String doc_num) {
		// TODO Auto-generated method stub
		return documentDao.selectDocument(doc_num);
	}

	@Override
	public String searchFolderId(Company com) {
		// TODO Auto-generated method stub
		return documentDao.searchFolderId(com);
	}

}
