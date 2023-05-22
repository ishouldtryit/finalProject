package com.kh.synergyZone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.component.RandomComponent;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private RandomComponent randomComponent;
	
	@Autowired
	private JavaMailSender sender;
	
	@GetMapping("/findPw")
	public String findPw() {
		return "employee/findPw";
	}
	
//	//비밀번호 찾기
//	@PostMapping("/findPw")
//	public String findPw(@RequestParam String empNo,
//						 @RequestParam String empEmail) {
//		EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
//		if(employeeDto == null || !employeeDto.getEmpEmail().equals(empEmail)) {
//			return "redirect:/employee/findPw";
//		}
//		
//		//이메일 일치 시 임시 비밀번호 생성
//		String temporaryPw = randomComponent.generateString();
//		
//		
//	}
}
