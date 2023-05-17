package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.vo.PaginationVO;

public interface EmployeeRepo {
	void insert(EmployeeDto employeeDto);
	EmployeeDto selectOne(String empNo);
    int getCount();
	List<EmployeeDto> list();
	List<EmployeeDto> getEmployeeList(PaginationVO vo);
	void delete(String empNo);
    List<EmployeeDto> searchEmployees(String column, String keyword);
}
