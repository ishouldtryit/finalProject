package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;

@RestController
@RequestMapping("/rest/approval")
public class ApprovalRestController {

	@Autowired
	private ApprovalRepoImpl approvalRepoImpl;
	
	@GetMapping("/")
	public List<ApprovalDto> list(){
		return approvalRepoImpl.selectList();
	}
	
	
		
	
	
	
}
