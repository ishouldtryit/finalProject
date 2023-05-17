package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.CalendarDto;
import com.kh.synergyZone.dto.CalendarScheduleDto;

@Repository
public class CalendarRepoImpl implements CalendarRepo{

	@Override
	public int insertMySchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		int mResult = sqlSession.insert("CalendarMapper.insertMySchedule", calendarScheduleDto);
		return mResult;
	}
	@Override
	public int insertComSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		int cResult = sqlSession.insert("CalendarMapper.insertComSchedule", calendarScheduleDto);
		return cResult;
	}
	@Override
	public int insertDeptSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		int dResult = sqlSession.insert("CalendarMapper.insertDeptSchedule", calendarScheduleDto);
		return dResult;
	}

	@Override
	public List<CalendarScheduleDto> selectAllSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		List<CalendarScheduleDto> sList = sqlSession.selectList("CalendarMapper.selectAllSchedule", calendarScheduleDto);
		return sList;
	}
	@Override
	public List<CalendarScheduleDto> selectAllComSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		List<CalendarScheduleDto> sList = sqlSession.selectList("CalendarMapper.selectAllComSchedule", calendarScheduleDto);
		return sList;
	}
	@Override
	public CalendarScheduleDto selectOneSchedule(SqlSession sqlSession, int schNo) {
		CalendarScheduleDto calendarScheduleDto = sqlSession.selectOne("CalendarMapper.selectOneSchedule", schNo);
		return calendarScheduleDto;
	}
	
	@Override
	public int updateSchedule(CalendarScheduleDto calendarScheduleDto, SqlSession sqlSession) {
		int result = sqlSession.update("CalendarMapper.updateSchedule", calendarScheduleDto);
		return result;
	}
	@Override
	public int deleteSchedule(int schNo, SqlSession sqlSession) { // 일정 삭제
		int result = sqlSession.delete("CalendarMapper.deleteSchedule", schNo);
		return result;
	}
	@Override
	public int registerCalendar(CalendarDto calendarDto, SqlSession sqlSession) {
		int result = sqlSession.insert("CalendarMapper.insertCalendar", calendarDto);
		return result;
	}

	@Override
	public List<CalendarDto> selectCalMyList(SqlSession sqlSession, CalendarDto calendarDto) {
		List<CalendarDto> cList = sqlSession.selectList("CalendarMapper.selectCalMyList", calendarDto);
		return cList;
	}

	@Override
	public int deleteCalendar(int calNo, SqlSession sqlSession) {
		int result = sqlSession.delete("CalendarMapper.deleteCalendar", calNo);
		return result;
	}
	
	// 홈 - 일정
	@Override
	public List<CalendarScheduleDto> selectListHomeCal(SqlSession sqlSession, CalendarScheduleDto calendarScheduleDto) { // 일정 목록
		List<CalendarScheduleDto> cList = sqlSession.selectList("CalendarMapper.selectListHomeCal", calendarScheduleDto);
		return cList;
	}

	@Override
	public CalendarScheduleDto selectOneHomeCal(SqlSession sqlSession, int schNo) { // 일정 상세
		CalendarScheduleDto calendarScheduleDto = sqlSession.selectOne("CalendarMapper.selectOneHomeCal", schNo);
		return calendarScheduleDto;
	}

	@Override
	public List<CalendarScheduleDto> selectAllHomeCal(SqlSession sqlSession, String empNo) { // 전체 일정 목록
		List<CalendarScheduleDto> sList = sqlSession.selectList("CalendarMapper.selectAllHomeCal", empNo);
		return sList;
	}
	
	// 알림
	@Override
	public CalendarScheduleDto selectLastCalendarScheduleDto(SqlSession sqlSession) { // 최근 전사 일정 조회
		CalendarScheduleDto calendarScheduleDto = sqlSession.selectOne("CalendarMapper.selectLastCalendarScheduleDto");
		return calendarScheduleDto;
	}
	@Override
	public List<CalendarScheduleDto> selectMyCalendar(int calNo, SqlSession sqlSession) {
		List<CalendarScheduleDto> cList = sqlSession.selectList("CalendarMapper.selectCalList", calNo);
		return cList;
	}
	
	
}