package com.kh.synergyZone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HomeController {

		@GetMapping("/")
		public String home() {
			return "home";
		}
		
		@PostMapping("/testuser1")
		public String loginTestuser1(
				HttpSession session
				) {
			 session.removeAttribute("memberId");
			 session.removeAttribute("jobNo");
			 session.setAttribute("memberId", "testuser1");
			 session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/testuser2")
		public String loginTestuser2(
				HttpSession session
				) {
			session.removeAttribute("memberId");
			session.removeAttribute("jobNo");
			session.setAttribute("memberId", "testuser2");
			session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/testuser3")
		public String loginTestuser3(
				HttpSession session
				) {
			session.removeAttribute("memberId");
			session.removeAttribute("jobNo");
			session.setAttribute("memberId", "testuser3");
			session.setAttribute("jobNo", "99");
			return "redirect:/";
		}
		@PostMapping("/logout")
		public String logout(
				HttpSession session
				) {
			session.removeAttribute("memberId");
			session.removeAttribute("jobNo");
			return "redirect:/";
		}
	
} 
