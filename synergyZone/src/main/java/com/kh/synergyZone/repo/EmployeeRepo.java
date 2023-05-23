package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface EmployeeRepo {
	 void insert(EmployeeDto employeeDto);
	   EmployeeDto selectOne(String empNo);
	   List<EmployeeInfoDto> list();
	   void update(EmployeeDto employeeDto);
	   void exit(String empNo);
	   void delete(String empNo);
	   List<DeptEmpListVO> treeSelect();
	   
	   String lastEmpNoOfYear(String year);
	   
	   List<EmployeeDto> waitingList();

	   int getCount();
	   List<EmployeeDto> getEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchEmployees(String column, String keyword);
}	
