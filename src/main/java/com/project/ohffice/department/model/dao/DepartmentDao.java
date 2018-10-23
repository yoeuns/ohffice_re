package com.project.ohffice.department.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.department.model.vo.Department;

@Repository("departmentDao")
public class DepartmentDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public DepartmentDao() {}
	
	public ArrayList<Department> departmentList() {
		return (ArrayList)sqlSession.selectList("departmentMapper.selectDepartmentList");
	}

	public int insertDept(Map<String, String> map) {
		return sqlSession.insert("departmentMapper.insertDept", map);
	}

	public int updateDept(Map<String, String> map) {
		return sqlSession.update("departmentMapper.updateDept", map);
	}

	public int deleteDept(String dept_num) {
		return sqlSession.delete("departmentMapper.deleteDept", dept_num);
	}

}
