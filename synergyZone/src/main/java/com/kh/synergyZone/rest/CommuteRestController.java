package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.repo.CommuteRecordRepoImpl;
@CrossOrigin
@RestController
@RequestMapping("/rest/commute")
public class CommuteRestController {
	@Autowired
	private CommuteRecordRepoImpl commuteRepo;
	
	@GetMapping("/")
	public List<CommuteRecordDto> record(Model model,HttpSession session) {
		String empNo = (String) session.getAttribute("empNo");
		return commuteRepo.allList(empNo);
	}
}
