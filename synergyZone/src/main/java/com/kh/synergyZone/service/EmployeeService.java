package com.kh.synergyZone.service;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.EmployeeDto;

public interface EmployeeService {
	EmployeeDto login(EmployeeDto employeeDto);
	void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException;
	void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException;
	void deleteProfile(String empNo);
	
	String generateEmpNo(Date empHireDate);
	
	List<EmployeeDto> searchEmployees(String column, String keyword);
}