package com.project.ohffice.department.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.department.model.dao.DepartmentDao;
import com.project.ohffice.department.model.vo.Department;

@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	private DepartmentDao departmentDao;
	
	public DepartmentServiceImpl() {}
	
	@Override
	public ArrayList<Department> departmentList() {
		return departmentDao.departmentList();
	}

	@Override
	public int insertDept(Map<String, String> map) {
		return departmentDao.insertDept(map);
	}

	@Override
	public int updateDept(Map<String, String> map) {
		return departmentDao.updateDept(map);
	}

	@Override
	public int deleteDept(String dept_num) {
		return departmentDao.deleteDept(dept_num);
	}
}
