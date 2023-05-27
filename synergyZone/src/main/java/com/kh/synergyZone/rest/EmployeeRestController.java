package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/rest/employee")
public class EmployeeRestController {
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@GetMapping("/")
	public List<EmployeeDto> adminList(){
		return employeeRepo.adminList();
	}
	@PostMapping("/")
	public void addAdmin(@RequestBody EmployeeDto employeeDto) {
		employeeRepo.authorityAdmin(employeeDto.getEmpNo());
	}
}
