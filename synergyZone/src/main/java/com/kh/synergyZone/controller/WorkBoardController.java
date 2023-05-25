package com.kh.synergyZone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.repo.WorkBoardRepo;

@Controller
@RequestMapping("/workboard")
public class WorkBoardController {
	
	@Autowired
	private WorkBoardRepo workBoardRepo;
	
	@GetMapping("/write")
	public String write(Model model) {
		return "workboard/write";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute WorkBoardDto workBoardDto,
						HttpSession session) {
		String empNo = (String) session.getAttribute("empNo");
		workBoardDto.setEmpNo(empNo);
		
		int workNo = workBoardRepo.sequence();
		workBoardDto.setWorkNo(workNo);
		
		
		System.out.println(workBoardDto.getWorkSecret());
		workBoardRepo.insert(workBoardDto);
		
		return "redirect:/";
	}
}
