package com.kh.synergyZone.repo;

import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.CalendarVO;
import com.kh.synergyZone.vo.PaginationVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class CalendarRepoImpl implements CalendarRepo{

	@Autowired
	private SqlSession sqlSession;


	@Override
	public int insert(CalendarVO calendarVO) {
		int rs = sqlSession.insert("Calendar.insert", calendarVO);
		return rs ;
	}

}