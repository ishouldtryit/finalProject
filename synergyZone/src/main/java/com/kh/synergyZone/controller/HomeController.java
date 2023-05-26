package com.kh.synergyZone.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.repo.CommuteRecordRepo;

@Controller
public class HomeController {

		@Autowired
		private CommuteRecordRepo commuteRecordRepo;
		
		@GetMapping("/")
		public String home(Model model, HttpSession session, @ModelAttribute CommuteRecordDto commuteRecordDto) {
		    String empNo = (String) session.getAttribute("memberId");
//		    if (empNo != null) {
//		        CommuteRecordDto today = commuteRecordRepo.today(empNo);
//		        System.out.println(today);
//		        if (today!=null) {
//		            CommuteRecordDto w = today;
//		            model.addAttribute("work", w);
//		        }
//		    }
		    
		    return "home";
		}
		
		@PostMapping("/testuser1")
		public String loginTestuser1(
				HttpSession session
				) {
			 session.removeAttribute("empNo");
			 session.removeAttribute("jobNo");
			 session.setAttribute("empNo", "202399001");
			 session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/testuser2")
		public String loginTestuser2(
				HttpSession session
				) {
			session.removeAttribute("memberId");
			session.removeAttribute("jobNo");
			session.setAttribute("empNo", "202399002");
			session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/testuser3")
		public String loginTestuser3(
				HttpSession session
				) {
			session.removeAttribute("memberId");
			session.removeAttribute("jobNo");
			session.setAttribute("empNo", "202399003");
			session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/logout")
		public String logout(
				HttpSession session
				) {
			session.removeAttribute("empNo");
			session.removeAttribute("jobNo");
			return "redirect:/";
		}
		
		@PostMapping("/start")
		public String start(HttpSession session,@ModelAttribute CommuteRecordDto commuteRecordDto,
				Model model) {
			
			String empNo =(String)session.getAttribute("memberId");
			commuteRecordRepo.insert(empNo);
			 return "redirect:/";
		}
		
		@PostMapping("/end")
		public String end(HttpSession session,@ModelAttribute CommuteRecordDto commuteRecordDto) {
			String empNo =(String)session.getAttribute("memberId");
			commuteRecordDto.setEmpNo(empNo);
			commuteRecordRepo.update(empNo);
			return "redirect:/";
		}
	
} 
