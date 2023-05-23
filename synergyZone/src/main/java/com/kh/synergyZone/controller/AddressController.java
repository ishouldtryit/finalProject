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
import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/address")
public class AddressController {
   
   @Autowired 
   private EmployeeRepo employeeRepo;
   
   @Autowired 
   private AttachmentRepo attachmentRepo;
   
   @Autowired 
   private CustomFileUploadProperties fileuploadProperties;
   
   @Autowired
   private EmployeeService employeeService;
   
   @Autowired
   private EmployeeProfileRepo employeeProfileRepo;
   
   @Autowired
	private DepartmentRepo departmentRepo;
	
	@Autowired
	private JobRepo jobRepo;
	
   // 관리자 홈
   @GetMapping("/")
   public String home() {
      return "address";
   }
   
   @GetMapping("/list")
   public String list(Model model, @ModelAttribute("vo") PaginationVO vo,
           @RequestParam(required = false, defaultValue = "") String empNo,
           @RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
           @RequestParam(required = false, defaultValue = "") String column,
           @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
       List<EmployeeInfoDto> employees;

       // 검색
       if (!column.isEmpty() && !keyword.isEmpty()) {
           employees = employeeService.searchEmployees(column, keyword);
       } else {
           employees = employeeRepo.list();
       }


       // 직위, 부서별 조회
       List<DepartmentDto> departments = departmentRepo.list();
       List<JobDto> jobs = jobRepo.list();

       model.addAttribute("departments", departments);
       model.addAttribute("jobs", jobs);

       // 프로필 사진 조회
       EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
       model.addAttribute("profile", profile);
       model.addAttribute("employees", employees);

       // 멤버 수 조회를 통한 리스트
       int totalMemberCnt = employeeRepo.getCount();
       vo.setCount(totalMemberCnt);

       return "address/list";
   }
   
   //사원 상세
 	@GetMapping("/detail")
 	public String detail(@RequestParam String empNo,
 						Model model) {
 		model.addAttribute("employeeDto", employeeRepo.selectOne(empNo));
 		model.addAttribute("profile", employeeProfileRepo.find(empNo));
 		return "employee/detail";
 	}
    
   
    
    
}