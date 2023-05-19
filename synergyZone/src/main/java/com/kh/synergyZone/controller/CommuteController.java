package com.kh.synergyZone.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.repo.CommuteRecordRepo;

@Controller
@RequestMapping("/commute")
public class CommuteController {
	@Autowired
	private CommuteRecordRepo commuteRecordRepo;
	//근태관리 메인
	@GetMapping("/")
	public String commute(Model model, HttpSession session, @ModelAttribute CommuteRecordDto commuteRecordDto) {
		//사원번호
		String empNo = (String) session.getAttribute("memberId");
		System.out.println(commuteRecordRepo.today(empNo));
		//오늘 근무정보
		model.addAttribute("w",commuteRecordRepo.today(empNo));
		
		
		return "/commute/commute";
	}
	
	// 출/퇴근 변경
	@PostMapping("/change")
	public String changeCommute(Model model, HttpSession session,HttpServletRequest request) {
		//사원번호
		String empNo = (String) session.getAttribute("memberId");
		int status =Integer.parseInt(request.getParameter("status"));
		
		//출근처리
		//출근버튼 1
		if(status==1) {
			commuteRecordRepo.insert(empNo);
		}
		//퇴근버튼 2
		else if(status==2) {
			commuteRecordRepo.update(empNo);
		}
		
		return "redirect:/commute/";
	}
	
	@GetMapping("/record")
	public String record(Model model,HttpSession session) {
		String empNo = (String) session.getAttribute("memberId");
		List<CommuteRecordDto> list=commuteRecordRepo.allList(empNo);
		model.addAttribute("list",list);
		System.out.println(list);
		return "/commute/record";
	}
	
	
	@GetMapping("/vacation")
	public String vacation(Model model,HttpSession session) {
		String empNo = (String) session.getAttribute("memberId");
		
		return "/commute/vacation";		
		
	}
}
