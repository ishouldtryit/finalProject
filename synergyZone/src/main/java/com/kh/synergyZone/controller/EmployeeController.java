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

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;
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
	
	@GetMapping("/detail")
	public String detail(@RequestParam String empNo,
						Model model) {
		model.addAttribute("employeeDto", employeeService.detailEmployee(empNo));
		model.addAttribute("profile", employeeService.getEmployeeProfile(empNo));
		return "employee/detail";
	}
	
	
	
	
}
