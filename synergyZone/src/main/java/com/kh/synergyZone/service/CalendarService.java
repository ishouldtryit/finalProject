package com.kh.synergyZone.service;

import com.kh.synergyZone.repo.CalendarRepo;
import com.kh.synergyZone.vo.CalendarVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;


//서비스(Service)
//- 컨트롤러에서 처리하기 복잡한 작업들을 단위작업으로 끊어서 수행하는 도구
//- 보통 하나의 기능을 하나의 메소드에 보관
//- 정해진 형태 없이 자유롭게 사용
@Service
public class CalendarService {

    @Autowired
    private CalendarRepo calendarRepo;


    public  int insertDate(CalendarVO vo) {
        int rs = 0;
        rs = calendarRepo.insert(vo);
        return rs ;
    }


   


    public List<Map<String,Object>> getDate(CalendarVO vo) {
        return calendarRepo.getDate(vo);
    }

    public int deleteDate(CalendarVO vo) {
        return calendarRepo.deleteDate(vo);
    }

    public Map<String, Object> detailView(CalendarVO vo) {
        return calendarRepo.detailView(vo);
    }

    public void updateDate(CalendarVO vo) {
        calendarRepo.updateDate(vo);
    }
}



