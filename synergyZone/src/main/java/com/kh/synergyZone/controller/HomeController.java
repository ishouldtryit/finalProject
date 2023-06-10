package com.kh.synergyZone.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.repo.CommuteRecordRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.LoginRecordRepo;
import com.kh.synergyZone.service.EmployeeService;

@Controller
public class HomeController {
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private CommuteRecordRepo commuteRecordRepo;

	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	
	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private LoginRecordRepo loginRecordRepo;

	@GetMapping("/")
	public String home(Model model, HttpSession session, @ModelAttribute CommuteRecordDto commuteRecordDto) {
		String empNo = (String) session.getAttribute("empNo");
		if (empNo != null) {
			// 오늘 근무정보
			model.addAttribute("w", commuteRecordRepo.today(empNo));

			// 프로필 사진 조회
			EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
			model.addAttribute("profile", profile);
			return "main"; // 로그인된 사용자는 메인 페이지로 이동
		}

		// 프로필 사진 조회
		EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
		model.addAttribute("profile", profile);
		return "login";
	}

	// 로그인
	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute EmployeeDto employeeDto, HttpSession session, HttpServletRequest request,
			RedirectAttributes attr) {
		
		//최종 퇴사 사원 로그인 제한
		String empNo = employeeDto.getEmpNo();
		EmployeeDto exitDto = employeeRepo.selectOne(empNo);
		boolean isFinalExit = exitDto.getIsLeave().equals("Y");
		
	    if (isFinalExit) {
	        attr.addAttribute("mode", "error");
	        return "redirect:login";
	    }

		
		EmployeeDto findDto = employeeService.login(employeeDto);

		if (findDto != null) {
			// 로그인 시 세션 저장
			session.setAttribute("empName", findDto.getEmpName());
			session.setAttribute("empNo", findDto.getEmpNo());
			session.setAttribute("jobNo", findDto.getJobNo());
			session.setAttribute("deptNo", findDto.getDeptNo());
			session.setAttribute("empAdmin", findDto.getEmpAdmin());

			String ipAddress = employeeService.getLocation(request);
			String browserAddress = employeeService.getBrowser(request);

			// 로그인 접속 시간
			LoginRecordDto loginRecordDto = new LoginRecordDto();
			loginRecordDto.setEmpNo(findDto.getEmpNo());
			loginRecordDto.setLogIp(ipAddress);
			loginRecordDto.setLogBrowser(browserAddress);

			loginRecordRepo.insert(loginRecordDto);
		} else {
			attr.addAttribute("mode", "error");
			return "redirect:login";
		}

		return "redirect:/";
	}

	@GetMapping("/testHome")
	public String testHome() {
		return "/home";
	}

	@PostMapping("/testuser1")
	public String loginTestuser1(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		session.setAttribute("empNo", "202399001");
		session.setAttribute("jobNo", "99");
		return "redirect:/";
	}

	@PostMapping("/testuser2")
	public String loginTestuser2(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		session.setAttribute("empNo", "202399002");
		session.setAttribute("jobNo", "99");
		return "redirect:/";
	}

	@PostMapping("/testuser3")
	public String loginTestuser3(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		session.setAttribute("empNo", "202399003");
		session.setAttribute("jobNo", "99");
		return "redirect:/";
	}

	@PostMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("jobNo");
		return "redirect:/";
	}

}
