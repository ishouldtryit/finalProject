package com.kh.synergyZone.controller;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.LoginRecordRepo;
import com.kh.synergyZone.service.EmailService;
import com.kh.synergyZone.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
		@Autowired
		private EmployeeRepo employeeRepo;
		
		@Autowired
		private LoginRecordRepo loginRecordRepo;
		
		@Autowired
		private EmailService emailService;
		
		@Autowired
		private EmployeeService employeeService;
	
	
		//로그인
		@GetMapping("/login")
		public String login() {
			return "employee/login";
		}
		
		@PostMapping("/login")
		public String login(@ModelAttribute EmployeeDto employeeDto,
							HttpSession session,
							HttpServletRequest request) {
			EmployeeDto findDto = employeeService.login(employeeDto);
			if(findDto != null){
				//로그인 시 세션 저장
				session.setAttribute("empNo", findDto.getEmpNo());
				session.setAttribute("jobNo", findDto.getJobNo());
				
				String ipAddress = employeeService.getLocation(request);
				String browserAddress = employeeService.getBrowser(request);

				//로그인 접속 시간
				LoginRecordDto loginRecordDto = new LoginRecordDto();
				loginRecordDto.setEmpNo(findDto.getEmpNo());
				loginRecordDto.setLogIp(ipAddress);
				loginRecordDto.setLogBrowser(browserAddress);
				
				loginRecordRepo.insert(loginRecordDto);
			}
			
			return "redirect:/";
		}
		
		//로그아웃
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("empNo");
			session.removeAttribute("jobNo");
			return "redirect:/";
		}
	
		@GetMapping("/findPw")
		public String findPw() {
			return "employee/findPw";
		}
		
		@PostMapping("/findPw")
		public String findPw(@RequestParam String empNo,
							 @RequestParam String empEmail,
							 RedirectAttributes attr) throws MessagingException {
			EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
			if(employeeDto == null || !employeeDto.getEmpEmail().equals(empEmail)) {
				attr.addAttribute("mode", "error");
				return "redirect:findPw";
			}
			
			//이메일 일치 시 임시 비밀번호 생성
			emailService.sendTemporaryPw(empNo, empEmail);
			return "redirect:findPwResult";
		}
		
		
		@GetMapping("/findPwResult")
		public String findPwResult() {
			return "employee/findPwResult";
		}
}
