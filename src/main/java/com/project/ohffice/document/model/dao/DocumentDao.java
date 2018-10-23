package com.project.ohffice.document.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.company.model.vo.Company;
import com.project.ohffice.document.model.vo.Document;
import com.project.ohffice.document.model.vo.Folder;

@Repository("documentDao")
public class DocumentDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertFolder(Folder folder) {
	
		return sqlSession.insert("FolderMapper.insertFolder", folder);
	}

	public String selectFolder(Folder folder) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FolderMapper.selectFolder", folder);
	}

	public ArrayList<Object> selectFolders(String url) {
		// TODO Auto-generated method stub
		return (ArrayList<Object>) sqlSession.selectList("FolderMapper.selectFolders", url);
	}

	public int insertDocument(Document doc) {

		return sqlSession.insert("DocumentMapper.insertDocument", doc);
	}

	public List<Document> selectDraftList(String email) { //여기서 타입은 무슨리스트를 불러오는지 타입으로 결정..
		
		return sqlSession.selectList("DocumentMapper.selectDraftList", email);
	}

	public Document selectDocument(String doc_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DocumentMapper.selectDocument", doc_num);
	}

	public String searchFolderId(Company com) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FolderMapper.searchFolderId", com);
	}
	
	

}
