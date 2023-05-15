package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.synergyZone.dto.CalendarDto;
import com.kh.synergyZone.dto.CalendarScheduleDto;

public interface CalendarRepo {
	
	//개인 일정 등록
		public int insertMySchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//전사 일정 등록
		public int insertComSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//부서 일정 등록
		public int insertDeptSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//캘린더에 일정 목록 띄우기
		public List<CalendarScheduleDto> selectAllSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//전사일정 목록 띄우기
		public List<CalendarScheduleDto> selectAllComSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//일정 상세
		public CalendarScheduleDto selectOneSchedule(SqlSession sqlSession, int schNo);
		//일정 수정
		public int updateSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession);
		//일정 삭제
		public int deleteSchedule(int schNo, SqlSession sqlSession);
		//내 캘린더 등록
		public int registerCalendar(CalendarDto calendarDto, SqlSession sqlSession);
		//내 캘린더 목록 조회
		public List<CalendarDto> selectCalMyList(SqlSession sqlSession, CalendarDto calendarDto);
		public int deleteCalendar(int calNo, SqlSession sqlSession);
		
		// 홈 - 일정
		public List<CalendarScheduleDto> selectListHomeCal(SqlSession sqlSession, CalendarScheduleDto calendarScheduleDto); // 일정 목록

		public CalendarScheduleDto selectOneHomeCal(SqlSession sqlSession, int schNo); // 일정 상세

		public List<CalendarScheduleDto> selectAllHomeCal(SqlSession sqlSession, String empNum); // 전체 일정 목록
		
		// 알림
		public CalendarScheduleDto selectLastCalendarScheduleDto(SqlSession sqlSession); // 최근 전사 일정 조회
		//내 캘린더 조회
		public List<CalendarScheduleDto> selectMyCalendar(int calNo, SqlSession sqlSession);
		
		

		

	}
