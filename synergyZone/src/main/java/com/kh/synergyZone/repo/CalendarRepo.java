package com.kh.synergyZone.repo;

import com.kh.synergyZone.vo.CalendarVO;

import java.util.List;
import java.util.Map;

public interface CalendarRepo {
   void insert(CalendarVO vo);

   List<Map<String,Object>> getDate(CalendarVO vo);

   boolean deleteDate(CalendarVO vo);

   Map<String, Object> detailView(CalendarVO vo);
   
   CalendarVO detailView2(int seq);
   
   boolean updateDate(CalendarVO vo);
   
   
   
}