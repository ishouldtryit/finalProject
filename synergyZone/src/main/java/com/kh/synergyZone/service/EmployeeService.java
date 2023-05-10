package com.kh.synergyZone.service;

import com.kh.synergyZone.dto.EmployeeDto;

public interface EmployeeService {
	void join(EmployeeDto employeeDto);
	EmployeeDto login(EmployeeDto employeeDto);
}
