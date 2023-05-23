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
import com.kh.synergyZone.vo.EmployeeExitWaitingVO;
import com.kh.synergyZone.vo.LoginRecordSearchVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
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
        
        return "admin/join";
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
	
	
	//프로필 이미지 수정
	@PostMapping("/profile/update")
	public String updateProfile(@RequestParam String empNo,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if (!attach.isEmpty()) {
	        employeeService.updateProfile(empNo, attach);
	    }
		return "redirect:/admin/detail?empNo="+empNo;
	}
	
	//프로필 이미지 삭제
	@GetMapping("/profile/delete")
	public String deleteProfile(@RequestParam String empNo) {
		employeeService.deleteProfile(empNo);
		return "redirect:/admin/detail?empNo=" + empNo;
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
	    
	    return "admin/list";
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
	    
	    model.addAttribute("profile", employeeProfileRepo.find(empNo));
	    
	    
	    
		return "admin/edit";
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
		return "redirect:/admin/list";
	}
	
	//사원 상세
	@GetMapping("/detail")
	public String detail(@RequestParam String empNo,
						Model model) {
		model.addAttribute("employeeDto", employeeRepo.selectOne(empNo));
		model.addAttribute("profile", employeeProfileRepo.find(empNo));
		return "admin/detail";
	}
	
	//사원 퇴사
	@GetMapping("/delete")
	public String deleteEmployee(@RequestParam String empNo) {
		employeeRepo.delete(empNo);
		return "redirect:/admin/waitingList";
	}
	
	@GetMapping("/exit")
	public String exitEmployee(@RequestParam String empNo) {
		employeeRepo.exit(empNo);
		return "redirect:/admin/list";
	}
	
	
	//부서 등록
	@GetMapping("/department/register")
	public String departmentRegister() {
		return "admin/department/register";
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
		return "admin/department/list";
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
		return "admin/job/register";
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
		return "admin/job/list";
	}
	
	//직위 삭제
	@GetMapping("/job/delete")
	public String deleteJob(@RequestParam int jobNo) {
		jobRepo.delete(jobNo);
		return "redirect:/";
	}
	
	//접속로그
	
	//접속로그 목록
	@GetMapping("/log/list")
	public String logList(@ModelAttribute("vo") LoginRecordSearchVO vo,
						  Model model) {
		//사원명
		List<EmployeeDto> employees = employeeRepo.list();
		
		model.addAttribute("employees", employees);
		
		//검색
		List<LoginRecordDto> loginRecordList;
		if(vo.isSearch()) {
			loginRecordList = loginRecordRepo.logList(vo);
		}
		else {
			loginRecordList = loginRecordRepo.list();
		}
		model.addAttribute("loginRecordList", loginRecordList);
		
		return "admin/log/list";
	}
	
	//퇴사처리 대기 목록
	@GetMapping("/waitingList")
	public String exitWaitingList(Model model) {
		List<EmployeeDto> waitingList = employeeRepo.waitingList();
		EmployeeExitWaitingVO exitWaitingVO = EmployeeExitWaitingVO.builder()
												.waitingList(waitingList)
												.build(); 
		model.addAttribute("exitWaitingVO", exitWaitingVO);
		
		List<DepartmentDto> departments = departmentRepo.list();
	    List<JobDto> jobs = jobRepo.list();
	    
	    model.addAttribute("departments", departments);
	    model.addAttribute("jobs", jobs);
	    
		return "admin/waitingList";
	}
	
	
	
}