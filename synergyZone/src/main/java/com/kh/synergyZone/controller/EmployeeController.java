package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;
import com.kh.synergyZone.repo.LoginRecordRepo;
import com.kh.synergyZone.service.EmailService;
import com.kh.synergyZone.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
		@Autowired
		private EmployeeRepo employeeRepo;
		
		@Autowired
		private DepartmentRepo departmentRepo;
		
		@Autowired
		private JobRepo jobRepo;
	
		@Autowired
		private EmployeeProfileRepo employeeProfileRepo;
		
		@Autowired
		private LoginRecordRepo loginRecordRepo;
		
		@Autowired
		private EmailService emailService;
		
		@Autowired
		private EmployeeService employeeService;
		
		@Autowired
		private PasswordEncoder encoder;
	
	
//		//로그인
//		@GetMapping("/login")
//		public String login() {
//			return "employee/login";
//		}
//		
//		@PostMapping("/login")
//		public String login(@ModelAttribute EmployeeDto employeeDto,
//							HttpSession session,
//							HttpServletRequest request) {
//			EmployeeDto findDto = employeeService.login(employeeDto);
//			
//			if(findDto != null){
//				//로그인 시 세션 저장
//				session.setAttribute("empName", findDto.getEmpName());
//				session.setAttribute("empNo", findDto.getEmpNo());
//				session.setAttribute("jobNo", findDto.getJobNo());
//				
//				String ipAddress = employeeService.getLocation(request);
//				String browserAddress = employeeService.getBrowser(request);
//
//				//로그인 접속 시간
//				LoginRecordDto loginRecordDto = new LoginRecordDto();
//				loginRecordDto.setEmpNo(findDto.getEmpNo());
//				loginRecordDto.setLogIp(ipAddress);
//				loginRecordDto.setLogBrowser(browserAddress);
//				
//				loginRecordRepo.insert(loginRecordDto);
//			}
//			
//			return "redirect:/";
//		}
		
		//로그아웃
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("empNo");
			session.removeAttribute("jobNo");
			return "redirect:/";
		}
		
		//사원 상세
		@GetMapping("/mypage")
		public String mypage(HttpSession session,
							Model model) {
			String empNo = (String) session.getAttribute("empNo");
			
			model.addAttribute("employeeDto", employeeRepo.selectOne(empNo));
			model.addAttribute("profile", employeeProfileRepo.find(empNo));
			return "employee/mypage";
		}
		
		//비밀번호 찾기
		@GetMapping("/findPw")
		public String findPw() {
			return "employee/findPw";
		}
		
		@PostMapping("/findPw")
		public String findPw(@RequestParam("empNo") String empNo,
							 @RequestParam("empEmail") String empEmail,
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
		
		//비밀번호 변경
		@GetMapping("/password")
		public String password() {
			return "employee/password";
		}
		
		@PostMapping("/password")
		public String password(HttpSession session,
		                       @RequestParam String currentPw,
		                       @RequestParam String changePw,
		                       RedirectAttributes attr) {
		    String empNo = (String) session.getAttribute("empNo");
		    EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
		    
		    if (!encoder.matches(currentPw, employeeDto.getEmpPassword())) {
		        attr.addAttribute("mode", "error");
		        return "redirect:password";
		    }
		    
		    employeeDto.setEmpNo(empNo);
		    employeeDto.setEmpPassword(changePw);

		    String encrypt = encoder.encode(employeeDto.getEmpPassword());
		    employeeDto.setEmpPassword(encrypt);
		    
		    employeeRepo.changePw(employeeDto);
		    return "redirect:passwordFinish";
		}
		
		@GetMapping("/passwordFinish") 
		public String passwordFinish() {
			return "employee/passwordFinish";
		}
}