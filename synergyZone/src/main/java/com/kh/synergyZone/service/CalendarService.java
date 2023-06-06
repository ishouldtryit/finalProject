package com.kh.synergyZone.service;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.BoardFileDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.BoardFileRepo;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.repo.CalendarRepo;
import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.CalendarVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
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
}



