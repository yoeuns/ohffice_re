package com.project.ohffice.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.project.ohffice.employee.model.vo.CommonInfo;
import com.project.ohffice.employee.model.vo.Employee;
import com.project.ohffice.employee.model.vo.EmployeeList;


public interface EmpService {

	int empInsert(Employee emp);

	int ismember(Employee emp);

	String selectCompany(Employee emp);
	
	int updateCompanyEmployee(HashMap map);

	Employee selectEmp(String email);
	
	 ArrayList<CommonInfo> infoList();

	int insertMyEmp(Employee emp);

	int updateEmpId(Employee emp);

	int updateCertification(Employee emp);

	ArrayList<EmployeeList> empList();

	int deleteEmp(String emp_email);

	int updateEmpDept(Employee emp);
	
	public abstract Employee myInfo(String email);

	public abstract int changeMyInfo(Employee emp);

	public abstract List<EmployeeList> empInfo(String comURL);

	public abstract List<EmployeeList> selectDept(String dept_name);


}
