package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	//회원가입
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
	
	//로그인
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
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		return "redirect:/";
	}
	
	//사원 목록
	@GetMapping("/list")
	public String list(Model model) throws IOException {
		List<EmployeeDto> employees = employeeService.getAllEmployees();
		model.addAttribute("employees" ,employees);
		
//		 Map<Integer, ResponseEntity<ByteArrayResource>> profileMap = new HashMap<>();
//
//		    // 각 사원의 프로필 이미지 정보를 가져와서 Map에 추가합니다.
//		    for (EmployeeDto employee : employees) {
//		        EmployeeProfileDto profile = employeeService.getEmployeeProfile(employee.getEmpNo());
//		        if (profile != null) {
//		            int attachmentNo = profile.getAttachmentNo(); // 프로필 이미지의 attachmentNo 가져오기
//		            ResponseEntity<ByteArrayResource> profileResponse = employeeService.getProfile(attachmentNo);
//		            profileMap.put(attachmentNo, profileResponse);
//		        }
//		    }
//
//		    model.addAttribute("profileMap", profileMap);

		return "employee/list";
	}
	
	//사원 상세
	@GetMapping("/detail")
	public String detail(@RequestParam String empNo,
						Model model) {
		model.addAttribute("employeeDto", employeeService.detailEmployee(empNo));
		return "employee/detail";
	}
	
	
	//부서 등록
	@GetMapping("/department/register")
	public String departmentRegister() {
		return "department/register";
	}
	
	
	@PostMapping("/department/register")
	public String departmentRegister(@ModelAttribute DepartmentDto departmentDto) {
		employeeService.registerDepartment(departmentDto);
		return "redirect:/";
	}
	
	//부서 목록
	@GetMapping("/department/list")
	public String departmentList(Model model) {
		List<DepartmentDto> departments = employeeService.getAllDepartments();
		model.addAttribute("departments",departments);
		return "department/list";
	}
	
//	//부서 삭제
//	@GetMapping("/department/delete")
//	public String departmentDelete(@RequestParam int deptNo) {
////		DepartmentDto departmentDto = employeeService
//	}
//	
	
	
	
}
