package com.kh.synergyZone.controller;

import com.kh.synergyZone.repo.*;
import com.kh.synergyZone.service.CalendarService;
import com.kh.synergyZone.vo.CalendarVO;
import com.kh.synergyZone.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
       // 현재 로그인 한 사번
       model.addAttribute("emp", empNo);
       return "calendar/calendar";
   }

    // 등록 창 이동
    @GetMapping("/insertPage")
    public String insertPage(Model model, @ModelAttribute("vo") CalendarVO vo,
                       @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
        Map<String,Object> rsMap= calendarService.detailView(vo);
        model.addAttribute("result", rsMap);
        return "calendar/insertPage";
    }
    // 등록
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

    // 수정
    @PostMapping("/updateDate")
    public String updateDate(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session,
                             @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
        String empNo = (String) session.getAttribute("empNo");
        String empName = (String) session.getAttribute("empName");
        vo.setEmp_no(empNo);
        vo.setEmp_name(empName);
         calendarService.updateDate(vo);
        return "redirect:/calendar/calendar";
    }



/*   @PostMapping("/detailView")
    public ModelAndView detailView(Model model, @ModelAttribute("vo") CalendarVO vo, HttpSession session,
                                   @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
        ModelAndView mv = new ModelAndView("calendar/insertPage");
        Map<String, Object> rsMap= calendarService.detailView(vo);
        mv.setViewName("redirect:/insertDate");
        mv.addObject("result", rsMap);
        return mv;
    } */


    // 삭제
    @PostMapping("/deleteDate")
    public String deleteDate(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session,
                             @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {

        int rs = calendarService.deleteDate(vo);

        if(rs >0) {
            return "calendar/calendar";
        } else {
            return "삭제 실패";
        }
    }
}