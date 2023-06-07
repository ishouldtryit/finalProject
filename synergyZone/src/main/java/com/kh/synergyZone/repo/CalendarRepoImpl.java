package com.kh.synergyZone.repo;

import com.kh.synergyZone.vo.CalendarVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public class CalendarRepoImpl implements CalendarRepo{

	@Autowired
	private SqlSession sqlSession;


	@Override
	public int insert(CalendarVO calendarVO) {
		int rs = sqlSession.insert("Calendar.insertDate", calendarVO);
		return rs ;
	}

	@Override
	public void updateDate(CalendarVO calendarVO) {
		sqlSession.update("Calendar.updateDate", calendarVO);
	}

	@Override
	public int deleteDate(CalendarVO calendarVO) {
		int rs = sqlSession.delete("Calendar.deleteDate", calendarVO);
		return rs ;
	}

	@Override
	public List<Map<String,Object>> getDate(CalendarVO calendarVO) {
		//sqlSession.insert("Calendar.getDate", calendarVO);
		return sqlSession.selectList("Calendar.getDate", calendarVO);
	}


	@Override
	public Map<String,Object> detailView(CalendarVO calendarVO) {
		Map<String,Object> test = sqlSession.selectOne("Calendar.detailView", calendarVO);
		return sqlSession.selectOne("Calendar.detailView", calendarVO);
	}

}