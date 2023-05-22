package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.vo.PaginationVO;

public interface EmployeeRepo {
	   void insert(EmployeeDto employeeDto);
	   EmployeeDto selectOne(String empNo);
	   List<EmployeeDto> list();
	   void update(EmployeeDto employeeDto);
	   void exit(String empNo);
	   void delete(String empNo);
	   
	   String lastEmpNoOfYear(String year);
	   
	   List<EmployeeDto> waitingList();


	   int getCount();
	        List<EmployeeDto> getEmployeeList(PaginationVO vo);
	   List<EmployeeDto> searchEmployees(String column, String keyword);
}