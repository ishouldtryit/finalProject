package com.kh.synergyZone.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.JobDto;

public interface EmployeeService {
	EmployeeDto login(EmployeeDto employeeDto);
	void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException;
	void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException;
	void deleteProfile(String empNo);
	List<EmployeeDto> getAllEmployees();
	EmployeeDto detailEmployee(String empNo);
	void deleteEmployee(String empNo);
	
	void registerDepartment(DepartmentDto departmentDto);
	List<DepartmentDto> getAllDepartments();
	void deleteDepartment(int deptNo);
	
	void registerJob(JobDto jobDto);
	List<JobDto> getAllJobs();
	void deleteJob(int jobNo);
	List<EmployeeDto> searchEmployees(String column, String keyword);
}
