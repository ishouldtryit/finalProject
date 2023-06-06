package com.kh.synergyZone.controller;

import com.kh.synergyZone.repo.*;
import com.kh.synergyZone.service.CalendarService;
import com.kh.synergyZone.vo.CalendarVO;
import com.kh.synergyZone.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

   @Autowired
   private EmployeeRepo employeeRepo;

   @Autowired
   private CalendarService calendarService;

   // 관리자 홈


   // 캘린더 풀 화면
   @GetMapping("/calendar")
   public String list(Model model, @ModelAttribute("vo") CalendarVO vo, HttpSession session,
           @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
       String empNo = (String) session.getAttribute("empNo");
       String empName = (String) session.getAttribute("empName");
       vo.setEmp_no(empNo);
       vo.setEmp_name(empName);
       List<Map<String,Object>> resultList = calendarService.getDate(vo);
       model.addAttribute("result", resultList);
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
    public String insertPage(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session,
                             @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
        String empNo = (String) session.getAttribute("empNo");
        String empName = (String) session.getAttribute("empName");
        vo.setEmp_no(empNo);
        vo.setEmp_name(empName);
       int rs = calendarService.insertDate(vo);
       if(rs >0) {
           return "calendar/insertPage";
       } else {
           return "calendar/calendar";
       }
    }
}