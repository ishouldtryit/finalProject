package com.kh.synergyZone.service;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
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
	void updateEmployee(EmployeeDto employeeDto);
	void exitEmployee(String empNo);
	void deleteEmployee(String empNo);
	
	String generateEmpNo(Date empHireDate);
	
	void registerDepartment(DepartmentDto departmentDto);
	List<DepartmentDto> getAllDepartments();
	void deleteDepartment(int deptNo);
	
	void registerJob(JobDto jobDto);
	List<JobDto> getAllJobs();
	void deleteJob(int jobNo);
}
