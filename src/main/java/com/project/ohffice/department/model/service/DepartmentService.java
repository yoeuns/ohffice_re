package com.project.ohffice.department.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.project.ohffice.department.model.vo.Department;

public interface DepartmentService {

	ArrayList<Department> departmentList();
	int insertDept(Map<String, String> map);
	int updateDept(Map<String, String> map);
	int deleteDept(String dept_num);
}
