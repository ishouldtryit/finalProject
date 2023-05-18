package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepoImpl;

@RestController
@RequestMapping("/rest/employee")
public class EmployeeRestController2 {
	
	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	
	//부서 목록 불러오기
	@GetMapping("/")
	public List<EmployeeDto> list(){
		return employeeRepoImpl.list();
	}
	
	
	
	
	
	
	
}
