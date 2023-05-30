package com.kh.synergyZone.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.kh.synergyZone.repo.EmployeeRepo;

@CrossOrigin
@RestController
@RequestMapping("/admin")
public class AdminRestController {
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@PutMapping("/{empNo}")
	public void authorityAdmin(@PathVariable String empNo) throws NoHandlerFoundException {
		boolean result = employeeRepo.authorityAdmin(empNo);
		if(result == false)
			throw new NoHandlerFoundException(null, null, null);
	}
	
	
}
