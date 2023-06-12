package com.kh.synergyZone.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.mail.MessagingException;
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
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.dto.LoginRecordInfoDto;
import com.kh.synergyZone.dto.VacationInfoDto;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;
import com.kh.synergyZone.repo.LoginRecordRepo;
import com.kh.synergyZone.repo.VacationInfoRepoImpl;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.service.VacationServiceImpl;
import com.kh.synergyZone.vo.LoginRecordSearchVO;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private VacationServiceImpl vacaitonService;

	@Autowired
	private VacationInfoRepoImpl vacationRepo;

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
	private EmployeeProfileRepo employeeProfileRepo;

	@Autowired
	private PasswordEncoder encoder;

	// 회원가입
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
	public String join(@ModelAttribute EmployeeDto employeeDto, @RequestParam int deptNo, @RequestParam int jobNo,
			@RequestParam Date empHireDate, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException, MessagingException {

		String empNo = employeeService.generateEmpNo(empHireDate);
		employeeDto.setEmpNo(empNo);
		employeeDto.setDeptNo(deptNo);
		employeeDto.setJobNo(jobNo);

		employeeService.join(employeeDto, attach);

		VacationInfoDto info = new VacationInfoDto();

		int total = vacaitonService.calculateVacationDays(empHireDate);

		info.setEmpNo(empNo);
		info.setTotal(total);
		info.setResidual(total);

		vacationRepo.add(info);

		return "redirect:/admin/list";
	}

	// 프로필 이미지 수정
	@PostMapping("/profile/update")
	public String updateProfile(@RequestParam String empNo, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException {
		if (!attach.isEmpty()) {
			employeeService.updateProfile(empNo, attach);
		}
		return "redirect:/admin/detail?empNo=" + empNo;
	}

	// 프로필 이미지 삭제
	@GetMapping("/profile/delete")
	public String deleteProfile(@RequestParam String empNo) {
		employeeService.deleteProfile(empNo);
		return "redirect:/admin/detail?empNo=" + empNo;
	}

	// 사원 목록
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") PaginationVO vo,
			@RequestParam(required = false, defaultValue = "") String empNo,
			@RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
			@RequestParam(required = false, defaultValue = "") String column,
			@RequestParam(required = false, defaultValue = "") String keyword, Model model) throws IOException {
		List<EmployeeInfoDto> employees;

		// 검색
		if (!column.isEmpty() && !keyword.isEmpty()) {
			employees = employeeService.searchEmployees(column, keyword);
		} else {
			employees = employeeRepo.list();
		}
		if (empNo != null) {
			model.addAttribute("profile", employeeProfileRepo.find(empNo));
		}

		// 페이징 처리
		int totalCount = employees.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<EmployeeInfoDto> pagedEmployees = employees.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출

		// 직위, 부서별 조회
		List<DepartmentDto> departments = departmentRepo.list();
		List<JobDto> jobs = jobRepo.list();

		model.addAttribute("departments", departments);
		model.addAttribute("jobs", jobs);

		// selected 유지
		model.addAttribute("column", column);

		// 프로필 사진 조회
		EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
		model.addAttribute("profile", profile);

		model.addAttribute("employees", pagedEmployees);

		return "admin/list";
	}

	// 대기자 목록
	@GetMapping("/waitingList")
	public String waitingList(@ModelAttribute("vo") PaginationVO vo,
			@RequestParam(required = false, defaultValue = "") String empNo,
			@RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
			@RequestParam(required = false, defaultValue = "") String column,
			@RequestParam(required = false, defaultValue = "") String keyword, Model model) {
		List<EmployeeInfoDto> waitingList;

		// 대기 목록 조회
		if (!column.isEmpty() && !keyword.isEmpty()) {
			waitingList = employeeRepo.searchWaitingEmployees(column, keyword);
		} else {
			waitingList = employeeRepo.waitingList();
		}

		model.addAttribute("waitingList", waitingList);

		List<DepartmentDto> departments = departmentRepo.list();
		List<JobDto> jobs = jobRepo.list();

		model.addAttribute("departments", departments);
		model.addAttribute("jobs", jobs);

		if (empNo != null) {
			model.addAttribute("profile", employeeProfileRepo.find(empNo));
		}

		// selected 유지
		model.addAttribute("column", column);

		// 페이징 처리
		int totalCount = waitingList.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<EmployeeInfoDto> pagedEmployees = waitingList.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출

		// 프로필 사진 조회
		EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
		model.addAttribute("profile", profile);

		model.addAttribute("employees", pagedEmployees);

		return "admin/waitingList";
	}

	// 최종 퇴사자 목록
	@GetMapping("/exitList")
	public String exitList(@ModelAttribute("vo") PaginationVO vo,
			@RequestParam(required = false, defaultValue = "") String empNo,
			@RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
			@RequestParam(required = false, defaultValue = "") String column,
			@RequestParam(required = false, defaultValue = "") String keyword, Model model) {
		List<EmployeeInfoDto> exitList;

		// 대기 목록 조회
		if (!column.isEmpty() && !keyword.isEmpty()) {
			exitList = employeeRepo.searchExitEmployees(column, keyword);
		} else {
			exitList = employeeRepo.exitList();
		}

		model.addAttribute("exitList", exitList);

		List<DepartmentDto> departments = departmentRepo.list();
		List<JobDto> jobs = jobRepo.list();

		model.addAttribute("departments", departments);
		model.addAttribute("jobs", jobs);

		if (empNo != null) {
			model.addAttribute("profile", employeeProfileRepo.find(empNo));
		}

		// selected 유지
		model.addAttribute("column", column);

		// 페이징 처리
		int totalCount = exitList.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<EmployeeInfoDto> pagedEmployees = exitList.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출

		// 프로필 사진 조회
		EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
		model.addAttribute("profile", profile);

		model.addAttribute("employees", pagedEmployees);

		return "admin/exitList";
	}

	// 사원 정보 수정
	@GetMapping("/edit")
	public String edit(@RequestParam String empNo, Model model) {
		EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
		List<DepartmentDto> departments = departmentRepo.list();
		List<JobDto> jobs = jobRepo.list();

		String encrypt = encoder.encode(employeeDto.getEmpPassword());
		employeeDto.setEmpPassword(encrypt);

		model.addAttribute("employeeDto", employeeDto);
		model.addAttribute("departments", departments);
		model.addAttribute("jobs", jobs);

		model.addAttribute("profile", employeeProfileRepo.find(empNo));

		return "admin/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute EmployeeDto employeeDto, @RequestParam String empNo, @RequestParam int deptNo,
			@RequestParam int jobNo, HttpSession session, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException {
		employeeDto.setDeptNo(deptNo);
		employeeDto.setJobNo(jobNo);

		employeeService.deleteProfile(empNo);
		employeeService.updateProfile(empNo, attach);

		employeeRepo.update(employeeDto);
		return "redirect:/admin/list";
	}

	// 사원 상세
	@GetMapping("/detail")
	public String detail(@RequestParam String empNo, Model model) {
		model.addAttribute("employeeDto", employeeRepo.selectOne(empNo));
		model.addAttribute("profile", employeeProfileRepo.find(empNo));
		return "admin/detail";
	}

//	// 사원 삭제
//	@GetMapping("/delete")
//	public String deleteEmployee(@RequestParam String empNo) {
//		employeeRepo.delete(empNo);
//		return "redirect:/admin/waitingList";
//	}

	// 사원 퇴사
	@GetMapping("/exit")
	public String exitEmployee(@RequestParam String empNo) {
		employeeRepo.exit(empNo);
		return "redirect:/admin/list";
	}

	// 사원 퇴사 취소
	@GetMapping("/exitCancel")
	public String exitCancel(@RequestParam String empNo) {
		employeeRepo.cancelExit(empNo);
		return "redirect:/admin/waitingList";
	}

	// 사원 최종 퇴사
	@GetMapping("/finalExit")
	public String finalExit(@RequestParam String empNo) {
		EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
		employeeDto.setEmpEmail("9999");
		employeeDto.setEmpPhone("9999");
		employeeDto.setEmpAddress("9999");
		employeeDto.setEmpDetailAddress("9999");
		employeeDto.setEmpPostcode("9999");
		employeeDto.setIsLeave("Y");

		employeeRepo.finalExit(employeeDto);
		return "redirect:/admin/waitingList";
	}

	// 부서 등록
	@GetMapping("/department/register")
	public String departmentRegister() {
		return "admin/department/register";
	}

	@PostMapping("/department/register")
	public String departmentRegister(@ModelAttribute DepartmentDto departmentDto) {
		departmentRepo.insert(departmentDto);
		return "redirect:/";
	}

	// 부서 목록
	@GetMapping("/department/list")
	public String departmentList(@ModelAttribute("vo") PaginationVO vo,
			  					 @RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
								 Model model) {
		List<DepartmentDto> departments = departmentRepo.list();
		
		// 페이징 처리
		int totalCount = departments.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<DepartmentDto> pagedDeptList = departments.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출

		model.addAttribute("departments", pagedDeptList);
		return "admin/department/list";
	}

	// 부서 삭제
	@GetMapping("/department/delete")
	public String deleteDepartment(@RequestParam int deptNo) {
		departmentRepo.delete(deptNo);
		return "redirect:/";
	}

	// 직위 등록
	@GetMapping("/job/register")
	public String jobRegister() {
		return "admin/job/register";
	}

	@PostMapping("/job/register")
	public String jobRegister(@ModelAttribute JobDto jobDto) {
		jobRepo.insert(jobDto);
		return "redirect:/";
	}

	// 직위 목록
	@GetMapping("/job/list")
	public String jobList(@ModelAttribute("vo") PaginationVO vo,
						  @RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
						  Model model) {
		List<JobDto> jobs = jobRepo.list();
		
		// 페이징 처리
		int totalCount = jobs.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<JobDto> pagedJobList = jobs.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출

		model.addAttribute("jobs", pagedJobList);
		return "admin/job/list";
	}

	// 직위 삭제
	@GetMapping("/job/delete")
	public String deleteJob(@RequestParam int jobNo) {
		jobRepo.delete(jobNo);
		return "redirect:/";
	}

	// 접속로그

	// 접속로그 목록
	@GetMapping("/log/list")
	public String logList(@ModelAttribute("vo") PaginationVO vo,
					      @ModelAttribute LoginRecordSearchVO loginRecordSearchVO, Model model) {
		int totalCount = loginRecordRepo.selectCount(vo);
		vo.setCount(totalCount);
		List<LoginRecordInfoDto> list = loginRecordRepo.selectListByPaging(vo);
		model.addAttribute("list", list);
		return "admin/log/list";
	}

	// 관리자
	@GetMapping("/add")
	public String add(@ModelAttribute("vo") PaginationVO vo,
			@RequestParam(required = false, defaultValue = "") String empNo,
			@RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
			@RequestParam(required = false, defaultValue = "") String column,
			@RequestParam(required = false, defaultValue = "") String keyword, Model model,
			HttpSession session) {

		List<EmployeeInfoDto> adminList;

		// 대기 목록 조회
		if (!column.isEmpty() && !keyword.isEmpty()) {
			adminList = employeeRepo.searchAdminList(column, keyword);
		} else {
			adminList = employeeRepo.adminList();
		}

		List<DepartmentDto> departments = departmentRepo.list();
		List<JobDto> jobs = jobRepo.list();

		model.addAttribute("departments", departments);
		model.addAttribute("jobs", jobs);
		
		// selected 유지
		model.addAttribute("column", column);

		// 페이징 처리
		int totalCount = adminList.size(); // 전체 데이터 개수
		vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<EmployeeInfoDto> pagedadminList = adminList.subList(startIndex, endIndex); // 페이지에 해당하는 데이터만 추출


		model.addAttribute("adminList", pagedadminList);
		

		return "admin/add";
	}

	@PostMapping("/add")
	public String add(@RequestParam List<String> adminList, HttpSession session) {
		for (String empNo : adminList) {
		    employeeRepo.authorityAdmin(empNo);
		}

		return "redirect:/admin/add";
	}
	
	// 직위 삭제
	@GetMapping("/delete")
	public String deleteAdmin(@RequestParam String empNo) {
		employeeRepo.deleteAdmin(empNo);
		return "redirect:/admin/add";
	}

}