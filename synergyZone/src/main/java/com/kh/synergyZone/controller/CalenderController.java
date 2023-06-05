package com.kh.synergyZone.controller;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.repo.*;
import com.kh.synergyZone.service.CalendarService;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.vo.CalendarVO;
import com.kh.synergyZone.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/calendar")
public class CalenderController {
   
   @Autowired 
   private EmployeeRepo employeeRepo;
   
   @Autowired 
   private CalendarService calendarService;
	
   // 관리자 홈


   // 캘린더 풀 화면
   @GetMapping("/calendar")
   public String list(Model model, @ModelAttribute("vo") PaginationVO vo,
           @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {

       return "calendar/calendar";
   }

    // 사원 목록
    @GetMapping("/insertPage")
    public String insertPage(Model model, @ModelAttribute("vo") PaginationVO vo,
                       @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {

        return "calendar/insertPage";
    }
    // 사원 목록
    @PostMapping("/insertDate")
    public int insertPage(Model model, @ModelAttribute("vo") CalendarVO vo,
                             @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
       int rs = calendarService.insertDate(vo);
        return 0;
    }


}