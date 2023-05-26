package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.service.WorkBoardService;

@Controller
@RequestMapping("/workboard")
public class WorkBoardController {
	
	@Autowired
	private WorkBoardRepo workBoardRepo;
	
	@Autowired
	private WorkBoardService workBoardService;
	
	@GetMapping("/write")
	public String write(Model model) {
		return "workboard/write";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute WorkBoardDto workBoardDto,
						HttpSession session,
						@RequestParam("attachments") List<MultipartFile> attachments) throws IllegalStateException, IOException {
		String empNo = (String) session.getAttribute("empNo");
		workBoardDto.setEmpNo(empNo);
		
		int workNo = workBoardRepo.sequence();
		workBoardDto.setWorkNo(workNo);
		
		
//		System.out.println(workBoardDto.getWorkSecret());
		
		workBoardService.write(workBoardDto, attachments);
		
		
		return "redirect:/";
	}
}
