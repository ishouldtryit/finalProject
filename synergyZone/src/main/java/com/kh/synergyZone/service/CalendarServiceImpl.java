package com.kh.synergyZone.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.CalendarDto;
import com.kh.synergyZone.dto.CalendarScheduleDto;
import com.kh.synergyZone.repo.CalendarRepo;

@Service
public class CalendarServiceImpl implements CalendarService{

	@Autowired
	CalendarRepo cRepo;
	@Autowired
	SqlSession sqlSession;
	



	@Override
	public int registerMySchedule(CalendarScheduleDto calendarScheduleDto) {
		int mResult = cRepo.insertMySchedule(calendarScheduleDto, sqlSession);
		return mResult;
	}
	@Override
	public int registerComSchedule(CalendarScheduleDto calendarScheduleDto) {
		int cResult = cRepo.insertComSchedule(calendarScheduleDto, sqlSession);
		return cResult;
	}
	@Override
	public int registerDeptSchedule(CalendarScheduleDto calendarScheduleDto) {
		int dResult = cRepo.insertDeptSchedule(calendarScheduleDto, sqlSession);
		return dResult;
	}
	
	@Override
	public List<CalendarScheduleDto> printAllSchedule(CalendarScheduleDto calendarScheduleDto) {
		List<CalendarScheduleDto> sList = cRepo.selectAllSchedule(calendarScheduleDto, sqlSession);
		return sList;
	}
	@Override
	public List<CalendarScheduleDto> printAllComSchedule(CalendarScheduleDto calendarScheduleDto) {
		List<CalendarScheduleDto> cList = cRepo.selectAllComSchedule(calendarScheduleDto, sqlSession);
		return cList;
	}
	@Override
	public CalendarScheduleDto printOneSchedule(int schNo) {
		CalendarScheduleDto calendarScheduleDto = cRepo.selectOneSchedule(sqlSession, schNo);
		return calendarScheduleDto;
	}
	@Override
	public int modifySchedule(CalendarScheduleDto calendarScheduleDto) {
		int result = cRepo.updateSchedule(calendarScheduleDto, sqlSession);
		return result;
	}
	@Override
	public int deleteSchedule(int schNo) {
		int result = cRepo.deleteSchedule(schNo, sqlSession);
		return result;
	}
	@Override
	public int registerCalendar(CalendarDto calendarDto) {
		int result = cRepo.registerCalendar(calendarDto, sqlSession);
		return result;
	}
	@Override
	public List<CalendarDto> printAllMyCalendar(CalendarDto calendarDto) {
		List<CalendarDto> cList = cRepo.selectCalMyList(sqlSession, calendarDto);
		return cList;
	}
	@Override
	public int deleteCalendar(int calNo) {
		int result = cRepo.deleteCalendar(calNo, sqlSession);
		return result;
	}
	// 홈 - 일정
	@Override
	public List<CalendarScheduleDto> printListHomeCal(CalendarScheduleDto calendarScheduleDto) { // 일정 목록
		List<CalendarScheduleDto> cList = cRepo.selectListHomeCal(sqlSession, calendarScheduleDto);
		return cList;
	}
	@Override
	public CalendarScheduleDto printOneHomeCal(int schNo) { // 일정 상세
		CalendarScheduleDto calendarScheduleDto = cRepo.selectOneHomeCal(sqlSession, schNo);
		return calendarScheduleDto;
	}
	@Override
	public List<CalendarScheduleDto> printAllHomeCal(String empNo) { // 전체 일정 목록
		List<CalendarScheduleDto> sList = cRepo.selectAllHomeCal(sqlSession, empNo);
		return sList;
	}
	
	// 알림
	@Override
	public CalendarScheduleDto printLastCalendarScheduleDto() { // 최근 전사 일정 조회
		CalendarScheduleDto calendarScheduleDto = cRepo.selectLastCalendarScheduleDto(sqlSession);
		return calendarScheduleDto;
	}
	@Override
	public List<CalendarScheduleDto> printMyCalendar(int calNo) {
		List<CalendarScheduleDto> cList = cRepo.selectMyCalendar(calNo, sqlSession);
		return cList;
	}
	
	

}