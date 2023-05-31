package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;

@RestController
@RequestMapping("/rest/employee")
public class EmployeeRestController {
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@GetMapping("/")
	public List<EmployeeDto> adminList(){
		return employeeRepo.adminList();
	}
	
	@PutMapping("/{empNo}")
	public void authorityAdmin(@PathVariable String empNo) throws NoHandlerFoundException {
		boolean result = employeeRepo.authorityAdmin(empNo);
		if(result == false)
			throw new NoHandlerFoundException(null, null, null);
	}
}
