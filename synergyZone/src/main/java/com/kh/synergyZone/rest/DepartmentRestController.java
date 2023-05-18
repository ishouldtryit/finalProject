package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.repo.DepartmentRepoImpl;

@RestController
@RequestMapping("/rest/department")
public class DepartmentRestController {
	
	@Autowired
	private DepartmentRepoImpl departmentRepoImpl;
	
	//부서 목록 불러오기
	@GetMapping("/")
	public List<DepartmentDto> list(){
		return departmentRepoImpl.list();
	}
	
	
	
	
	
	
	
}
