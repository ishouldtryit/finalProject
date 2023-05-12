package com.kh.synergyZone.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;

public interface EmployeeService {
	EmployeeDto login(EmployeeDto employeeDto);
	void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException;
	void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException;
	ResponseEntity<ByteArrayResource> getProfile(int attachmentNo) throws IOException;
	void deleteProfile(String empNo);
	List<EmployeeDto> getAllEmployees();
	EmployeeDto detailEmployee(String empNo);
	EmployeeProfileDto getEmployeeProfile(String empNo);
}
