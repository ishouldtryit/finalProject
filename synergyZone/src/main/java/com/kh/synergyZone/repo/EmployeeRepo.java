package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;

public interface EmployeeRepo {
	void insert(EmployeeDto employeeDto);
	EmployeeDto selectOne(String empNo);
	List<EmployeeDto> list();
	void update(EmployeeDto employeeDto);
	void delete(String empNo);
}
