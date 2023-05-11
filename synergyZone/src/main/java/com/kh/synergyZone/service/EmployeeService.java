package com.kh.synergyZone.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.EmployeeDto;

public interface EmployeeService {
	EmployeeDto login(EmployeeDto employeeDto);
	void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException;
	void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException;
	void deleteProfile(String empNo);
}
