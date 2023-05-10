package com.kh.synergyZone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Autowired
	private ApprovalRepoImpl approvalRepoImpl;
	
	@GetMapping("/write")
	public String write() {
		return "/approval/write";
	}
	
	@PostMapping("/write")
	public String write(
			@ModelAttribute ApprovalDto approvalDto,
			HttpSession session
			) {
		String memberId = (String) session.getAttribute("memberId");
		approvalDto.setDrafterId(memberId);
		approvalRepoImpl.insert(approvalDto);
		return "redirect:/";
	}
	
	
}
