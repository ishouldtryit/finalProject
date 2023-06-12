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
   public void insert(CalendarVO calendarVO) {
      sqlSession.insert("Calendar.insertDate", calendarVO);
   }

   @Override
   public boolean updateDate(CalendarVO calendarVO) {
      return sqlSession.update("Calendar.updateDate", calendarVO)>0;
   }

   @Override
   public boolean deleteDate(CalendarVO calendarVO) {
      return sqlSession.delete("Calendar.deleteDate", calendarVO)>0;

   }

   @Override
   public List<Map<String,Object>> getDate(CalendarVO calendarVO) {
      //sqlSession.insert("Calendar.getDate", calendarVO);
      return sqlSession.selectList("Calendar.getDate", calendarVO);
   }


   @Override
   public Map<String, Object> detailView(CalendarVO calendarVO) {
      return sqlSession.selectOne("Calendar.detailView", calendarVO);
   }
   
   @Override
   public CalendarVO detailView2(int seq) {
      return sqlSession.selectOne("Calendar.detailView2", seq);
   }
   
   

}