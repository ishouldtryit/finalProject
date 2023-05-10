package com.kh.synergyZone.rest;

import org.springdoc.api.annotations.ParameterObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.repo.CommuteRecordRepo;

@CrossOrigin
@RestController
@RequestMapping("/home")
public class CommuteRecordRestController {
	@Autowired
	private CommuteRecordRepo commuteRecordRepo; 
	
	@PostMapping("/insert")
	public void insert(@ParameterObject @RequestBody CommuteRecordDto commuteRecordDto) {
		commuteRecordRepo.insert(commuteRecordDto);
	}
}
