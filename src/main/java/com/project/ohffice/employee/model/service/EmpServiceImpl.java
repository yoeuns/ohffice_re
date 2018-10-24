package com.project.ohffice.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.ohffice.employee.model.dao.EmpDao;
import com.project.ohffice.employee.model.vo.CommonInfo;
import com.project.ohffice.employee.model.vo.Employee;
import com.project.ohffice.employee.model.vo.EmployeeList;


@Service("empService")
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDao empDao;

	public EmpServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int empInsert(Employee emp) {

		return empDao.empInsert(emp);
	}

	@Override
	public int ismember(Employee emp) {
		// TODO Auto-generated method stub
		return empDao.ismember(emp);
	}

	@Override
	public String selectCompany(Employee emp) {
		// TODO Auto-generated method stub
		return empDao.selectCompany(emp);
	}

	@Override
	public int updateCompanyEmployee(HashMap map) {		
		return empDao.updateCompanyEmployee(map);
	}

	@Override
	public Employee selectEmp(String emp_email) {
		return empDao.selectEmp(emp_email);
	}
	
	@Override
	public ArrayList<CommonInfo> infoList(){
		return empDao.infoList();
	}

	@Override
	public int insertMyEmp(Employee emp) {
		return empDao.insertMyEmp(emp);
	}

	@Override
	public int updateEmpId(Employee emp) {
		return empDao.updateEmpId(emp);
	}

	@Override
	public int updateCertification(Employee emp) {
		return empDao.updateCertification(emp);		
	}

	@Override
	public ArrayList<EmployeeList> empList() {
		return empDao.empList();
	}

	@Override
	public int deleteEmp(String emp_email) {
		return empDao.deleteEmp(emp_email);
	}

	@Override
	public int updateEmpDept(Employee emp) {
		return empDao.updateEmpDept(emp);
	}

	@Override
	public Employee myInfo(String email) {
		return empDao.myInfo(email);
	}

	@Override
	public int changeMyInfo(Employee emp) {
		return empDao.changeMyInfo(emp);
	}

	@Override
	public List<EmployeeList> empInfo(String comURL) {
		return empDao.empInfo(comURL);
	}

	@Override
	public List<EmployeeList> selectDept(String dept_name) {
		return empDao.selectDept(dept_name);
	}

	@Override
	public int updateEmpPos(Employee emp) {
		return empDao.updateEmpPos(emp);
	}


}
