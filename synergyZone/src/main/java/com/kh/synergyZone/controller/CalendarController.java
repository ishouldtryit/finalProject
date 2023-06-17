package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.repo.CalendarRepo;
import com.kh.synergyZone.service.CalendarService;
import com.kh.synergyZone.vo.CalendarVO;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

   @Autowired
   private CalendarRepo calendarRepo;
   
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
       List<Map<String, Object>> owner = new ArrayList<>();
       for (Map<String, Object> item : resultList) {
    	    String itemEmpNo = (String) item.get("EMP_NO");
    	    if (empNo.equals(itemEmpNo)) {
    	        owner.add(item);
    	    }
    	}
       model.addAttribute("result", resultList);
       model.addAttribute("emp", empNo);
       
       //자신이 작성한것인지?
       model.addAttribute("owner",owner);
       
       return "calendar/calendar";
   }

    // 등록 창 이동
   @GetMapping("/insertPage")
   public String insertPage(Model model, @ModelAttribute("vo") CalendarVO vo,
                      @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
       if(vo.getSeq() == null || vo.getSeq().equals("")) {
            return "calendar/insertPage"; 
       } else {
           Map<String,Object> rsMap= calendarService.detailView(vo);
           model.addAttribute("result", rsMap);
           return "calendar/insertPage";

       }
   }
   
   
    // 등록
    @PostMapping("/insertDate")
    public String insertPage(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session,
                             @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {
        String empNo = (String) session.getAttribute("empNo");
        String empName = (String) session.getAttribute("empName");
        vo.setEmp_no(empNo);
        vo.setEmp_name(empName);
        calendarService.insertDate(vo);
        return "redirect:calendar";
    }
    
    // 수정
    @PostMapping("/edit")
    public String updateDate(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session,
                             @RequestParam(required = false, defaultValue =  "HttpServletRequest request, HttpServletResponse response, CalendarVO") String keyword) throws IOException {
        String empNo = (String) session.getAttribute("empNo");
        String empName = (String) session.getAttribute("empName");
        vo.setEmp_no(empNo);
        vo.setEmp_name(empName);
         calendarService.updateDate(vo);
        return "redirect:calendar";
    }

    @GetMapping("/edit")
    public String edit(Model model,
            @ModelAttribute("vo") CalendarVO vo,
            @RequestParam(required = false, defaultValue =  "HttpServletRequest request, HttpServletResponse response, CalendarVO") String keyword,
            @RequestParam int seq) throws IOException {
        // seq 값을 vo 객체에 설정합니다.
        vo.setSeq(seq);

        if(vo.getSeq() == null || vo.getSeq().equals("")) {
            return "calendar/calendar"; 
        } else {
            CalendarVO rsMap = calendarRepo.detailView2(seq);
            model.addAttribute("result", rsMap);
            return "calendar/edit";
        }
    }


    // 삭제
    @PostMapping("/deleteDate")
    public String deleteDate(Model model, @ModelAttribute("vo") CalendarVO vo,  HttpSession session) throws IOException {
        calendarService.deleteDate(vo);
        return "redirect:calendar";
    }
}