package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.service.EmployeeService;


@Controller
@RequestMapping("/admin")
public class AddressController {
   
   @Autowired private EmployeeRepo employeeRepo;
   
   @Autowired private AttachmentRepo attachmentRepo;
   
   @Autowired private CustomFileUploadProperties fileuploadProperties;
   
   @Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	
   // 관리자 홈
   @GetMapping("/address")
   public String home() {
      return "";
   }
   
   //사원 목록
 	@GetMapping("/list")
 	public String list(Model model) throws IOException {
 		List<EmployeeDto> employees = employeeService.getAllEmployees();
 		model.addAttribute("employees" ,employees);

 		return "";
 	}
   
 	//사원 상세
 		@GetMapping("/")
 		public String detail(@RequestParam String empNo,
 							Model model) {
 			model.addAttribute("employeeDto", employeeService.detailEmployee(empNo));
 			model.addAttribute("profile", employeeProfileRepo.find(empNo));
 			return "";
 	}
   
   
   
 
   
   
 
   
   
}
