package com.kh.synergyZone.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.kh.synergyZone.dto.CalendarDto;
import com.kh.synergyZone.dto.CalendarScheduleDto;
//import com.kh.synergyZone.member.domain.Member;
//import com.kh.synergyZone.member.service.MemberService;
//import com.kh.synergyZone.notice.domain.Notice;
import com.kh.synergyZone.service.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
//import com.google.gson.Gson;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
	
	@Autowired
	CalendarService cService;
	
	@GetMapping("/schWriteView")
	public String scheduleWriteView() {
		return "calendar/mainCalendar";
	}
	
	//일정 등록
	@ResponseBody
	@PostMapping ("/schRegister")
	public String scheduleRegister(ModelAndView mv, 
			@ModelAttribute CalendarScheduleDto calendarScheduleDto,
			HttpServletRequest request) {
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId"); // 세션 값 가져오기
			calendarScheduleDto.setEmpNo(memberId);
			int mResult = cService.registerMySchedule(calendarScheduleDto);
			// 알림 등
//			if(calendarScheduleDto.getSchCate().equals("전사")) {
//				alarmRegister();
//			}
//			if(mResult > 0) {
//				return new Gson().toJson(mResult);
//			}
				return null;
				
	}
	//일정 목록
	@ResponseBody
	@GetMapping("/schListView")
	public ModelAndView scheduleList(ModelAndView mv
			,HttpServletRequest request
			, @ModelAttribute CalendarScheduleDto calendarScheduleDto
			, @ModelAttribute CalendarDto calendarDto
			,@RequestParam(value= "schCate", required = false) String schCate
			) {
//		CalendarDto calendarDto = new CalendarDto();
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId"); // 세션 값 가져오기
		calendarScheduleDto.setEmpNo(memberId);
		List<CalendarScheduleDto> mList = new ArrayList<CalendarScheduleDto>();
		if( calendarScheduleDto.getSchCate() == null) {
			mList = cService.printAllSchedule(calendarScheduleDto);
		} else {
			mList = cService.printAllComSchedule(calendarScheduleDto);
		}
		calendarDto.setEmpNo(memberId);
		List<CalendarDto> cList = cService.printAllMyCalendar(calendarDto);
		mv.addObject("myCondition", "calendar");
		mv.addObject("mList", mList);
		mv.addObject("cList", cList);
		mv.addObject("schCate", schCate);
		mv.addObject("calNo", calendarScheduleDto.getCalNo());
		mv.setViewName("calendar/mainCalendar");
		return mv;
		
	}
	//일정 상세
	@ResponseBody
	@GetMapping("/schDetailView")
	public ModelAndView scheduleDetail(ModelAndView mv
			, @RequestParam("schNo") int schNo
			) {
		try {
		CalendarScheduleDto calendarScheduleDto = cService.printOneSchedule(schNo);
		if(calendarScheduleDto != null) {
			mv.addObject("calendarScheduleDto", calendarScheduleDto);
			mv.setViewName("calendar/mainCalendar");
			
		
		} else {
			mv.addObject("msg", "메일 상세 조회 실패");
			mv.setViewName("common/errorPage");
	
	} 
		}catch (Exception e) {
		mv.addObject("msg", e.toString());
		mv.setViewName("common/errorPage");
	}

		return mv;
		
	}
	
	//일정 수정
	@ResponseBody
	@PostMapping("/schModifyView")
	public ModelAndView scheduleUpdate(ModelAndView mv
			, @ModelAttribute CalendarScheduleDto calendarScheduleDto
			, HttpServletRequest request
			) {
		try{ HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId"); // 세션 값 가져오기
		calendarScheduleDto.setEmpNo(memberId);
		int result = cService.modifySchedule(calendarScheduleDto);
		if(result>0) {
			mv.setViewName("redirect:/calendar/schListView");
		} else {
			mv.addObject("msg", "등록 실패");
			mv.setViewName("common/errorPage");
		}
	}catch (Exception e) {
		mv.setViewName("common/errorPage");
		mv.addObject("msg", e.toString());
	}
				return mv;
		
	}
	//일정 삭제
	@ResponseBody
	@GetMapping("/schDelete")
	public String scheduleDelete(
			 @RequestParam("schNo") int schNo
			, HttpServletRequest request) {
		HttpSession session = request.getSession();
		CalendarScheduleDto calendarScheduleDto = new CalendarScheduleDto();
		String memberId = (String) session.getAttribute("memberId"); // 세션 값 가져오기
		calendarScheduleDto.setEmpNo(memberId);
		int result = cService.deleteSchedule(schNo);
		if(result>0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	@GetMapping("/calWriteView")
	public String calendarWriteView(HttpSession session) {
		String empNo = (String)session.getAttribute("memberId");
		return "calendar/mainCalendar";
	}
	//내 캘린더 등록
	@ResponseBody
	@PostMapping ("/calRegister")
	public ModelAndView calendarRegister(ModelAndView mv, 
			@ModelAttribute CalendarDto calendarDto, 
			HttpServletRequest request
			, @RequestParam(value="calName") String calName) {
		try {
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId"); // 세션 값 가져오기
			calendarDto.setEmpNo(memberId);
			calendarDto.setCalName(calName);
			int result = cService.registerCalendar(calendarDto);
			if(result>0) {
				mv.setViewName("redirect:/calendar/schListView");
			} else {
				mv.addObject("msg", "등록 실패");
//				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			//mv.setViewName("common/errorPage");
			mv.addObject("msg", e.toString());
		}
				return mv;
				
	}

	//내 캘린더 삭제
	@ResponseBody
	@GetMapping("/deleteCal")
	public String calendarDelete(
			@RequestParam("calNo") int calNo) {
		int result = cService.deleteCalendar(calNo);
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
}
	