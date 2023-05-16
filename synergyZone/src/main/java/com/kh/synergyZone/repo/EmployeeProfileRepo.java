package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.EmployeeProfileDto;

public interface EmployeeProfileRepo {
	void insert(EmployeeProfileDto employeeProfileDto);
	void delete(String empNo);
	void update(String empNo);
	EmployeeProfileDto find(String empNo);
}
