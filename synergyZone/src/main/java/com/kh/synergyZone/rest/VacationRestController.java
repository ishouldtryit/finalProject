package com.kh.synergyZone.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.VacationDto;
import com.kh.synergyZone.repo.VacationRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/vacation")
public class VacationRestController {
	@Autowired
	private VacationRepo repo;
	
	@GetMapping("/")
	public List<VacationDto> list() {
		return repo.selectList();
	}
}
