package com.kh.synergyZone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;
import com.kh.synergyZone.repo.EmployeeRepoImpl;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Autowired
	private ApprovalRepoImpl approvalRepoImpl;
	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	
	@GetMapping("/write")
	public String write() {
		return "/approval/write";
	}
	
	@PostMapping("/write")
	public String write(
			@ModelAttribute ApprovalDto approvalDto,
			HttpSession session
			) {
		String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");
		approvalDto.setDrafterId(memberId);
		approvalRepoImpl.insert(approvalDto);
		return "redirect:/approval/detail";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", approvalRepoImpl.selectList());
		return "/approval/list2";
	}
	
	@GetMapping("/detail")
	public String detail(Model model, @RequestParam int draftNo) {
		model.addAttribute("approvalDto", approvalRepoImpl.selectOne(draftNo));
		return "/approval/detail";
	}
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int draftNo) {
		model.addAttribute("approvalDto", approvalRepoImpl.selectOne(draftNo));
		return "/approval/edit";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ApprovalDto approvalDto) {
		approvalRepoImpl.edit(approvalDto);
		return "redirect:/approval/detail?draftNo="+approvalDto.getDraftNo();
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam int draftNo) {
		approvalRepoImpl.delete(draftNo);
		return "redirect:/approval/list";
	}
	
}
