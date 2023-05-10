package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.EmployeeDto;

public interface EmployeeRepo {
	void insert(EmployeeDto employeeDto);
	EmployeeDto selectOne(String empNo);
}
