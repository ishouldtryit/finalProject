package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/address")
public class AddressController {
   
   @Autowired private EmployeeRepo employeeRepo;
   
   @Autowired private AttachmentRepo attachmentRepo;
   
   @Autowired private CustomFileUploadProperties fileuploadProperties;
   
   @Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	
   // 관리자 홈
   @GetMapping("/")
   public String home() {
      return "address";
   }
   
   //사원 목록
   @GetMapping("/list")
   public String list(Model model, @ModelAttribute("vo") PaginationVO vo,
           @RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
           @RequestParam(required = false, defaultValue = "") String column,
           @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
       List<EmployeeDto> employees;
       
       if (!column.isEmpty() && !keyword.isEmpty()) {
           employees = employeeService.searchEmployees(column, keyword);
       } else {
           employees = employeeService.getAllEmployees();
       }
       
       model.addAttribute("employees", employees);

       int totalMemberCnt = employeeRepo.getCount();
       vo.setCount(totalMemberCnt);

       return "address/list";
   }
   
 	
   
 	
 	
}