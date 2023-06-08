package com.kh.synergyZone.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	//관리자 페이지
	@GetMapping("/adminList")
	public String adminList() {
		return "/admin/approval/adminList";
	}
	
	//내 기안서 목록
	@GetMapping("/myList")
	public String myList() {
		return "/approval/myList";
	}
	
	//결재자 대기 목록
	@GetMapping("/waitApproverList")
	public String waitApproverList() {
		return "/approval/waitApproverList";
	}
	
	//합의자 대기 목록
	@GetMapping("/waitAgreeorList")
	public String waitAgreeorList() {
		return "/approval/waitAgreeorList";
	}
	
	//참조 문서 목록
	@GetMapping("/recipientList")
	public String recipientList() {
		return "/approval/recipientList";
	}
	
	//열람 문서 목록
	@GetMapping("/readerList")
	public String readerList() {
		return "/approval/readerList";
	}
	
	//기안서 상세 페이지
	@GetMapping("/detail")
	public String detail() {
		return "/approval/detail";
	}
	
	@GetMapping("/edit")
	public String edit() {
		return "/approval/edit2";
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam int draftNo) {
		approvalRepoImpl.delete(draftNo);
		return "redirect:/approval/list";
	}
	
}
