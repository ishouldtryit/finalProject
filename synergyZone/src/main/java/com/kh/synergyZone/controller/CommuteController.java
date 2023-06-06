package com.kh.synergyZone.controller;

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

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.dto.TripDto;
import com.kh.synergyZone.repo.CommuteRecordRepoImpl;
import com.kh.synergyZone.repo.TripRepo;
import com.kh.synergyZone.repo.TripRepoImpl;
import com.kh.synergyZone.repo.VacationInfoRepoImpl;
import com.kh.synergyZone.repo.VacationRepoImpl;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.vo.VacationVO;

@Controller
@RequestMapping("/commute")
public class CommuteController {
	@Autowired
	private CommuteRecordRepoImpl commuteRecordRepo;
	@Autowired
	private VacationInfoRepoImpl vacationInfoRepo;
	@Autowired
	private VacationRepoImpl vacationRepo;
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private TripRepoImpl tripRepoImpl;
	
	
	//근태관리 메인
	@GetMapping("/")
	public String commute(Model model, HttpSession session,CommuteRecordDto commuteRecordDto) {
		//사원번호
		String empNo = (String) session.getAttribute("empNo");
		//오늘 근무정보
		model.addAttribute("w",commuteRecordRepo.today(empNo));
		
		
		return "/commute/commute";
	}
	
	// 출/퇴근 변경
	@PostMapping("/change")
	public String changeCommute(Model model, HttpSession session,HttpServletRequest request) {
		//사원번호
		String empNo = (String) session.getAttribute("empNo");
		int status =Integer.parseInt(request.getParameter("status"));
		
		//출근처리
		//출근버튼 1
		if(status==1) {
			String ipAddress = employeeService.getLocation(request);
			CommuteRecordDto dto=new CommuteRecordDto();
			dto.setEmpNo(empNo);
			dto.setStartIp(ipAddress);
			commuteRecordRepo.insert(dto);
		}
		//퇴근버튼 2
		else if(status==2) {
			String ipAddress = employeeService.getLocation(request);
			CommuteRecordDto dto=new CommuteRecordDto();
			dto.setEmpNo(empNo);
			dto.setEndIp(ipAddress);
			
			commuteRecordRepo.update(dto);
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/record")
	public String record(Model model,HttpSession session) {
		String empNo = (String) session.getAttribute("empNo");
		//사원 연차기록
		List<CommuteRecordDto> list=commuteRecordRepo.allList(empNo);
		model.addAttribute("list",list);
		return "/commute/record";
	}
	
	
	@GetMapping("/vacation")
	public String vacation(Model model,HttpSession session) {
		String empNo = (String) session.getAttribute("empNo");
		//사원 연차정보
		model.addAttribute("one",vacationInfoRepo.one(empNo));
		return "/commute/vacation";		
		
	}
	
	@GetMapping("/write")
	public String write(Model model,HttpSession session) {
		String empNo=(String) session.getAttribute("empNo");
		//사원 연차정보
		model.addAttribute("one",vacationInfoRepo.one(empNo));
		VacationVO vo =new VacationVO();
		vo.setEmpNo(empNo);
		List<VacationVO> list=vacationRepo.queue(vo);
		model.addAttribute("list",list);


		return "/commute/write";
	}
	
	@PostMapping("/write")
	public String add(@ModelAttribute VacationVO vo,HttpSession session) {
		String empNo=(String) session.getAttribute("empNo");
		vo.setEmpNo(empNo);
		//등록
		vacationRepo.insert(vo);
		return "redirect:/commute/write";
	}
	
	@GetMapping("/trip")
	public String trip() {
		return "/commute/write2";
	}
	@PostMapping("/trip")
	public String insert(@ModelAttribute TripDto tripDto,HttpSession session) {
		String empNo=(String) session.getAttribute("empNo");
		tripDto.setEmpNo(empNo);
		tripRepoImpl.insert(tripDto);
		return "redirect:/commute/trip";
	}
	//관리자 연차관리페이지
	@GetMapping("/adminList")
	public String adminList(HttpSession session,Model model){
		String empNo=(String)session.getAttribute("empNo");
		//관리자권한이 있는 사람만 리스트조회
		List<VacationVO> list=vacationRepo.adminList();
		model.addAttribute("list",list);
	
		return "/commute/vacationList";
	}
}
