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
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.dto.CommuteRecordDto;
import com.kh.synergyZone.dto.TripDto;
import com.kh.synergyZone.dto.TripPersonDto;
import com.kh.synergyZone.dto.VacationDto;
import com.kh.synergyZone.dto.VacationInfoDto;
import com.kh.synergyZone.repo.CommuteRecordRepoImpl;
import com.kh.synergyZone.repo.EmployeeRepoImpl;
import com.kh.synergyZone.repo.JobRepoImpl;
import com.kh.synergyZone.repo.TripPersonRepoImpl;
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
	
	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	
	@Autowired
	private JobRepoImpl jobRepoImpl;
	
	@Autowired
	private TripPersonRepoImpl personRepoImpl;
		
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
		//다시출근
		else if(status==3) {
			String ipAddress = employeeService.getLocation(request);
			CommuteRecordDto dto=new CommuteRecordDto();
			dto.setEmpNo(empNo);
			dto.setEndIp(ipAddress);			
			commuteRecordRepo.delete(dto);
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
	public String trip(Model model,HttpSession session) {
		//신청내역받아야함
		String empNo=(String) session.getAttribute("empNo");
		List<TripDto> list=tripRepoImpl.queue(empNo);
		model.addAttribute("list",list);
		return "/commute/write2";
	}
	@PostMapping("/trip")
	public String insert(@ModelAttribute TripDto tripDto,HttpSession session,@RequestParam List<String> supList) {
		String emp=(String) session.getAttribute("empNo");
		tripDto.setEmpNo(emp);
		tripRepoImpl.insert(tripDto);
		String no =personRepoImpl.one(emp);
		//tripNo 조회
		
		for (String empNo : supList) {
			   TripPersonDto dto = new TripPersonDto();
	           dto.setEmpNo(empNo);
	           dto.setTripNo(no);
	           personRepoImpl.insert(dto);
	       }
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
	
	
	//관리자 상세 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int vacationNo,Model model,HttpSession session) {
		String empNo=(String) session.getAttribute("empNo");
		Integer jobNo=(Integer) session.getAttribute("jobNo");
		model.addAttribute("id",employeeRepoImpl.getId(empNo));
		model.addAttribute("job",jobRepoImpl.name(jobNo));
		model.addAttribute("one",vacationInfoRepo.one(empNo));
		
		//연차조회 필요한것들
		model.addAttribute("list",vacationRepo.oneList(vacationNo));
		//여기까지
		
		//출장조회 필요한것들
		
		return "/commute/detail";
	}
	
	//관리자 상세 페이지
		@GetMapping("/tripDetail")
		public String detail2(Model model,HttpSession session,@RequestParam(required = false) Integer tripNo) {
			String empNo=(String) session.getAttribute("empNo");
			Integer jobNo=(Integer) session.getAttribute("jobNo");
			model.addAttribute("id",employeeRepoImpl.getId(empNo));
			model.addAttribute("job",jobRepoImpl.name(jobNo));
			model.addAttribute("one",vacationInfoRepo.one(empNo));
			
			
			//여기까지
			
			//출장조회 필요한것들
			
			return "/commute/tripDetail";
		}
	
	//관리자 연차결재 완료
	@PostMapping("/approval")
	public String approval(HttpServletRequest request,@ModelAttribute VacationInfoDto dto,@ModelAttribute VacationDto dto2) {
		//status 받아서 0 일때 반려 1일때 결재 처리
		int btn =Integer.parseInt(request.getParameter("btn"));
		if(btn==1) {
			//반려일시 디비 status값 2 로 변경 empNo까지넣어야함
			dto2.setStatus(2);
			vacationRepo.appoval(dto2);
		}
		if(btn==2) {
			//결재일시 디비 status값 1 로 변경 empNo까지 넣어야함
			dto2.setStatus(2);
			vacationRepo.appoval(dto2);
			vacationInfoRepo.used(dto);
		}
		return "redirect:/commute/adminList";
	}
	
	//관리자 출장결재 완료
	@PostMapping("/approval2")
	public String tripApproval() {
		//status 받아서 0 일때 반려 1일때 결재 처리
		return "redirect:/commute/adminList";
	}
	
	
	//어드민 출장내역페이지
	@GetMapping("/adminList2")
	public String tripList(Model model) {
		List<TripDto> list=tripRepoImpl.adminList();
		model.addAttribute("list",list);
		System.err.println(list);
		return "/commute/tripList";
	}
	
	@GetMapping("/tripList")
	public String tripList2(HttpSession session,Model model) {
		String empNo = (String) session.getAttribute("empNo");
		model.addAttribute("one",vacationInfoRepo.one(empNo));
		return "/commute/trip";
	}
	
}
