package com.kh.synergyZone.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;
import com.kh.synergyZone.repo.LoginRecordRepo;
import com.kh.synergyZone.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private DepartmentRepo departmentRepo;
	
	@Autowired
	private JobRepo jobRepo;
	
	@Autowired
	private LoginRecordRepo loginRecordRepo;
	
	@Autowired
	private AddressController addressController;
	
	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	//회원가입
    @GetMapping("/join")
    public String join(Model model) {
        List<DepartmentDto> departments = departmentRepo.list();
        List<JobDto> jobs = jobRepo.list();
        
        model.addAttribute("departments", departments);
        model.addAttribute("jobs", jobs);
        
        return "employee/join";
    }
    
    // 회원가입 처리
    @PostMapping("/join")
    public String join(@ModelAttribute EmployeeDto employeeDto,
                       @RequestParam int deptNo,
                       @RequestParam int jobNo,
                       @RequestParam Date empHireDate,
                       @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
    	
    	String empNo = employeeService.generateEmpNo(empHireDate);
    	employeeDto.setEmpNo(empNo);
        employeeDto.setDeptNo(deptNo);
        employeeDto.setJobNo(jobNo);
        
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
						HttpSession session,
						HttpServletRequest request) {
		EmployeeDto findDto = employeeService.login(employeeDto);
		if(findDto != null){
			//로그인 시 세션 저장
			session.setAttribute("empNo", findDto.getEmpNo());
			session.setAttribute("jobNo", findDto.getJobNo());
			
			String ipAddress = addressController.getLocation(request);
			
			//로그인 접속 시간
			LoginRecordDto loginRecordDto = new LoginRecordDto();
			loginRecordDto.setEmpNo(findDto.getEmpNo());
			loginRecordDto.setLogIp(ipAddress);
			
			loginRecordRepo.insert(loginRecordDto);
		}
		
		return "redirect:/";
	}
	
	
	//프로필 이미지 수정
	@PostMapping("/profile/update")
	public String updateProfile(@RequestParam String empNo,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if (!attach.isEmpty()) {
	        employeeService.updateProfile(empNo, attach);
	    }
		return "redirect:/employee/detail?empNo="+empNo;
	}
	
	//프로필 이미지 삭제
	@GetMapping("/profile/delete")
	public String deleteProfile(@RequestParam String empNo) {
		employeeService.deleteProfile(empNo);
		return "redirect:/employee/detail?empNo=" + empNo;
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
		List<EmployeeDto> employees = employeeRepo.list();
	    List<DepartmentDto> departments = departmentRepo.list();
	    List<JobDto> jobs = jobRepo.list();
	    
	    model.addAttribute("employees", employees);
	    model.addAttribute("departments", departments);
	    model.addAttribute("jobs", jobs);
	    
	    return "employee/list";
	}
	
	//사원 정보 수정
	@GetMapping("/edit")
	public String edit(@RequestParam String empNo, 
						Model model) {
		EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
		List<DepartmentDto> departments = departmentRepo.list();
	    List<JobDto> jobs = jobRepo.list();
	
		model.addAttribute("employeeDto", employeeDto);
		model.addAttribute("departments", departments);
	    model.addAttribute("jobs", jobs);
	    
	    
	    
		return "employee/edit";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute EmployeeDto employeeDto,
						@RequestParam String empNo,
						@RequestParam int deptNo,
						@RequestParam int jobNo,
						HttpSession session,
						@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		employeeDto.setDeptNo(deptNo);
        employeeDto.setJobNo(jobNo);
        
        employeeService.deleteProfile(empNo);
	    employeeService.updateProfile(empNo, attach);
        
		employeeRepo.update(employeeDto);
		return "redirect:/employee/list";
	}
	
	//사원 상세
	@GetMapping("/detail")
	public String detail(@RequestParam String empNo,
						Model model) {
		model.addAttribute("employeeDto", employeeRepo.selectOne(empNo));
		model.addAttribute("profile", employeeProfileRepo.find(empNo));
		return "employee/detail";
	}
	
	//사원 퇴사
	@GetMapping("/delete")
	public String deleteEmployee(@RequestParam String empNo) {
		employeeRepo.delete(empNo);
		return "redirect:/";
	}
	
	@GetMapping("/exit")
	public String exitEmployee(@RequestParam String empNo) {
		employeeRepo.exit(empNo);
		return "redirect:/employee/list";
	}
	
	
	//부서 등록
	@GetMapping("/department/register")
	public String departmentRegister() {
		return "department/register";
	}
	
	
	@PostMapping("/department/register")
	public String departmentRegister(@ModelAttribute DepartmentDto departmentDto) {
		departmentRepo.insert(departmentDto);
		return "redirect:/";
	}
	
	//부서 목록
	@GetMapping("/department/list")
	public String departmentList(Model model) {
		List<DepartmentDto> departments = departmentRepo.list();
		model.addAttribute("departments",departments);
		return "department/list";
	}
	
	//부서 삭제
	@GetMapping("/department/delete")
	public String deleteDepartment(@RequestParam int deptNo) {
		departmentRepo.delete(deptNo);
		return "redirect:/";
	}
		
	//직위 등록
	@GetMapping("/job/register")
	public String jobRegister() {
		return "job/register";
	}
	
	@PostMapping("/job/register")
	public String jobRegister(@ModelAttribute JobDto jobDto) {
		jobRepo.insert(jobDto);
		return "redirect:/";
	}
	
	//직위 목록
	@GetMapping("/job/list")
	public String jobList(Model model) {
		List<JobDto> jobs = jobRepo.list();
		model.addAttribute("jobs", jobs);
		return "job/list";
	}
	
	//직위 삭제
	@GetMapping("/job/delete")
	public String deleteJob(@RequestParam int jobNo) {
		jobRepo.delete(jobNo);
		return "redirect:/";
	}
	
	
	
}