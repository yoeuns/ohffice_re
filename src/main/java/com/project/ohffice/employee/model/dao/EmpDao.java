package com.project.ohffice.employee.model.dao;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.ohffice.employee.model.vo.CommonInfo;
import com.project.ohffice.employee.model.vo.Employee;
import com.project.ohffice.employee.model.vo.EmployeeList;

@Repository("empDao")
public class EmpDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public EmpDao() {
		// TODO Auto-generated constructor stub
	}
	//濡쒓렇�씤 �슂泥��떆, �쉶�썝 �젙蹂� 由ы꽩�븯�뒗 硫붿냼�뱶

	public int empInsert(Employee emp) {

		return sqlSession.insert("employeeMapper.empInsert",emp);
	}

	public int ismember(Employee emp) {

		return sqlSession.selectOne("employeeMapper.empCount", emp);
	}

	public String selectCompany(Employee emp) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("employeeMapper.selectCompany",emp);
	}

	public int updateCompanyEmployee(HashMap map) {
		// TODO Auto-generated method stub
		return sqlSession.update("employeeMapper.updateCompanyEmployee",map);
	}

	public Employee selectEmp(String emp_email) {
		return sqlSession.selectOne("employeeMapper.selectEmp", emp_email);
	}
	

	public ArrayList<CommonInfo> infoList() {
		return (ArrayList)sqlSession.selectList("employeeMapper.selectInfoList");
	}

	public int insertMyEmp(Employee emp) {
		return sqlSession.insert("employeeMapper.insertMyEmp", emp);
	}

	public int updateEmpId(Employee emp) {
		return sqlSession.update("employeeMapper.updateEmpId", emp);
	}

	public int updateCertification(Employee emp) {
		return sqlSession.update("employeeMapper.updateCertification", emp);
	}

	public ArrayList<EmployeeList> empList() {
		return (ArrayList) sqlSession.selectList("employeeMapper.empList");
	}

	public int deleteEmp(String emp_email) {
		return sqlSession.delete("employeeMapper.deleteEmp", emp_email);
	}

	public int updateEmpDept(Employee emp) {
		return sqlSession.update("employeeMapper.updateEmpDept", emp);
	}

	public Employee myInfo(String email) {
		return (Employee) sqlSession.selectOne("employeeMapper.selectEmployee", email);
	}

	public int changeMyInfo(Employee emp) {
		return sqlSession.update("employeeMapper.updateEmployee", emp);
	}

	public List<EmployeeList> empInfo(String comURL) {
		return (List) sqlSession.selectList("employeeMapper.selectEmpCom", comURL);
	}

	public List<EmployeeList> selectDept(String dept_name) {
		return (List) sqlSession.selectList("employeeMapper.selectDept", dept_name);
	}

	public int updateEmpPos(Employee emp) {
		return sqlSession.update("employeeMapper.updateEmpPos", emp);
	}

}
