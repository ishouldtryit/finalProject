package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.repo.EmployeeRepoImpl;
import com.kh.synergyZone.vo.DeptEmpListVO;

@RestController
@RequestMapping("/rest/approval")
public class ApprovalRestController {

	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	
	@GetMapping("/")
	public List<DeptEmpListVO> list(){
		return employeeRepoImpl.treeSelect();
	}
	
	
		
	
	
	
}
