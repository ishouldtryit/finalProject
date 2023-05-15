package com.kh.synergyZone.service;

import java.util.List;

import com.kh.synergyZone.dto.CalendarDto;
import com.kh.synergyZone.dto.CalendarScheduleDto;

public interface CalendarService {

	
	// 개인 일정 등록
	public int registerMySchedule(CalendarScheduleDto calendarScheduleDto);
	// 전사 일정 등록
	public int registerComSchedule(CalendarScheduleDto calendarScheduleDto);
	//부서 일정 등록
	public int registerDeptSchedule(CalendarScheduleDto calendarScheduleDto);
	public List<CalendarScheduleDto> printAllSchedule(CalendarScheduleDto calendarScheduleDto);

	public CalendarScheduleDto printOneSchedule(int schNo);
	
	public int modifySchedule(CalendarScheduleDto calendarScheduleDto);
	
	public int deleteSchedule(int schNo);
	
	public int registerCalendar(CalendarDto calendar);
	// 내 캘린더 메뉴바에서 조회
	public List<CalendarDto> printAllMyCalendar(CalendarDto calendar);
	// 메뉴 캘린더 삭
	public int deleteCalendar(int calNo);
	
	// 홈 - 일정
	public List<CalendarScheduleDto> printListHomeCal(CalendarScheduleDto calendarScheduleDto); // 일정 목록
	
	public CalendarScheduleDto printOneHomeCal(int schNo); // 일정 상세

	public List<CalendarScheduleDto> printAllHomeCal(String empNo); // 전체 일정 목록
	
	// 알림
	public CalendarScheduleDto printLastCalendarScheduleDto(); // 최근 전사 일정 조회
	
	//내 캘린더 조회
	public List<CalendarScheduleDto> printMyCalendar(int calNo);
	//전사 일정 조회
	public List<CalendarScheduleDto> printAllComSchedule(CalendarScheduleDto calendarScheduleDto);
	



	

}