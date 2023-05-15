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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
//import com.google.gson.Gson;

@Controller
public class CalendarController {
	
	@Autowired
	CalendarService cService;
	
	@RequestMapping( value="/calendar/schWriteView.sw")
	public String scheduleWriteView() {
		return "calendar/mainCalendar";
	}
	
	//일정 등록
	@ResponseBody
	@RequestMapping (value="/calendar/schRegister.sw", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public String scheduleRegister(ModelAndView mv, 
			@ModelAttribute CalendarScheduleDto calendarScheduleDto,
			HttpServletRequest request) {
			HttpSession session = request.getSession();
//			Member member = (Member) session.getAttribute("loginUser"); // 세션 값 가져오기
//			CalendarScheduleDto.setMemNum(member.getMemberNum());
			int mResult = cService.registerMySchedule(calendarScheduleDto);
			// 알림 등
			if(calendarScheduleDto.getSchCate().equals("전사")) {
//				alarmRegister();
			}
			if(mResult > 0) {
//				return new Gson().toJson(mResult);
			}
				return null;
				
	}
	//일정 목록
	@ResponseBody
	@RequestMapping(value="/calendar/schListView.sw", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	public ModelAndView scheduleList(ModelAndView mv
			,HttpServletRequest request
			, @ModelAttribute CalendarScheduleDto calendarScheduleDto
			, @ModelAttribute CalendarDto calendarDto
			,@RequestParam(value= "schCate", required = false) String schCate
			) {
//		CalendarDto calendarDto = new CalendarDto();
		HttpSession session = request.getSession();
//		Member member = (Member) session.getAttribute("loginUser"); // 세션 값 가져오기
//		CalendarScheduleDto.setMemNum(member.getMemberNum());
		List<CalendarScheduleDto> mList = new ArrayList<CalendarScheduleDto>();
		if( calendarScheduleDto.getSchCate() == null) {
			mList = cService.printAllSchedule(calendarScheduleDto);
		} else {
			mList = cService.printAllComSchedule(calendarScheduleDto);
		}
//		calendarDto.setMemNum(member.getMemberNum());
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
	@RequestMapping(value="/calendar/schDetailView.sw", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
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
	@RequestMapping(value="/calendar/schModifyView.sw", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ModelAndView scheduleUpdate(ModelAndView mv
			, @ModelAttribute CalendarScheduleDto CalendarScheduleDto
			, HttpServletRequest request
			) {
		try{ HttpSession session = request.getSession();
//		Member member = (Member) session.getAttribute("loginUser"); // 세션 값 가져오기
//		CalendarScheduleDto.setMemNum(member.getMemberNum());
		int result = cService.modifySchedule(CalendarScheduleDto);
		if(result>0) {
			mv.setViewName("redirect:/calendar/schListView.sw");
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
	@RequestMapping(value="/calendar/schDelete.sw", method = RequestMethod.GET)
	public String scheduleDelete(
			 @RequestParam("schNo") int schNo
			, HttpServletRequest request) {
		HttpSession session = request.getSession();
		CalendarScheduleDto calendarScheduleDto = new CalendarScheduleDto();
//		Member member = (Member) session.getAttribute("loginUser"); // 세션 값 가져오기
//		CalendarScheduleDto.setMemNum(member.getMemberNum());
		int result = cService.deleteSchedule(schNo);
		if(result>0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	@RequestMapping( value="/calendar/calWriteView.sw")
	public String calendarWriteView() {
		return "calendar/mainCalendar";
	}
	//내 캘린더 등록
	@ResponseBody
	@RequestMapping ( value="/calendar/calRegister.sw", method = RequestMethod.POST)
	public ModelAndView calendarRegister(ModelAndView mv, 
			@ModelAttribute CalendarDto calendarDto, 
			HttpServletRequest request
			, @RequestParam(value="calName") String calName) {
		
		try {
			HttpSession session = request.getSession();
//			Member member = (Member) session.getAttribute("loginUser"); // 세션 값 가져오기
//			calendarDto.setMemNum(member.getMemberNum());
			calendarDto.setCalName(calName);
			int result = cService.registerCalendar(calendarDto);
			if(result>0) {
				mv.setViewName("redirect:/calendar/schListView.sw");
			} else {
				mv.addObject("msg", "등록 실패");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.setViewName("common/errorPage");
			mv.addObject("msg", e.toString());
		}
				return mv;
				
	}

	//내 캘린더 삭제
	@ResponseBody
	@RequestMapping(value="/calendar/deleteCal.sw", method=RequestMethod.GET)
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
	