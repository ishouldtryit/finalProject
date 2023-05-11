package com.kh.synergyZone.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	@GetMapping("/join")
	public String join() {
		return "employee/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute EmployeeDto employeeDto,
						@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		employeeService.join(employeeDto, attach);
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String login() {
		return "employee/login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute EmployeeDto employeeDto,
						HttpSession session) {
		EmployeeDto findDto = employeeService.login(employeeDto);
		if(findDto != null){
			session.setAttribute("empNo", findDto.getEmpNo());
			session.setAttribute("jobNo", findDto.getJobNo());
		}
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		return "redirect:/";
	}
	
	
	
}
