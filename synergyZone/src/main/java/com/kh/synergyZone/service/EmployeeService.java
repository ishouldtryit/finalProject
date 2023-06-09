package com.kh.synergyZone.service;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.BookmarkDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;

public interface EmployeeService {

	EmployeeDto login(EmployeeDto employeeDto);
	void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException, MessagingException;
	void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException;
	void deleteProfile(String empNo);
	
	String generateEmpNo(Date empHireDate);
	
	String getLocation(HttpServletRequest request);
	String getBrowser(HttpServletRequest request);
	
	List<EmployeeInfoDto> searchEmployees(String column, String keyword);
	
    List<BookmarkDto> searchEmployeesInMyList(String ownerNo, String column, String keyword);

	boolean encoder(EmployeeDto employeeDto);
}