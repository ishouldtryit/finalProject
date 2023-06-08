package com.kh.synergyZone.repo;

import com.kh.synergyZone.vo.CalendarVO;

import java.util.List;
import java.util.Map;

public interface CalendarRepo {
	void insert(CalendarVO vo);

	List<Map<String,Object>> getDate(CalendarVO vo);

	int deleteDate(CalendarVO vo);

	Map<String, Object> detailView(CalendarVO vo);

	void updateDate(CalendarVO vo);
}