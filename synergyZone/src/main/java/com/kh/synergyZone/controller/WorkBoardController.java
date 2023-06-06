package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkReportDto;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.repo.WorkFileRepo;
import com.kh.synergyZone.repo.WorkReportRepo;
import com.kh.synergyZone.service.WorkBoardService;
import com.kh.synergyZone.vo.ReportWithWorkBoardVO;
import com.kh.synergyZone.vo.WorkBoardVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/workboard")
@Slf4j
public class WorkBoardController {
   
   @Autowired
   private WorkBoardRepo workBoardRepo;
   
   @Autowired
   private DepartmentRepo departmentRepo;
   
   @Autowired
   private EmployeeRepo employeeRepo;
   
   @Autowired
   private WorkBoardService workBoardService;
   
   @Autowired
   private WorkFileRepo workFileRepo;
   
   @Autowired
   private WorkReportRepo workReportRepo;
   
   //업무일지 작성
   @GetMapping("/write")
   public String write(Model model) {
      List<EmployeeInfoDto> employees = employeeRepo.list();
      
      model.addAttribute("employees", employees);
      
      return "workboard/write";
   }
   
   @PostMapping("/write")
   public String write(@ModelAttribute WorkBoardDto workBoardDto,
                  HttpSession session,
                  WorkBoardVO workBoardVO,
                  RedirectAttributes rttr) throws IllegalStateException, IOException {
      String empNo = (String) session.getAttribute("empNo");
      workBoardDto.setEmpNo(empNo);
      
      int workNo = workBoardRepo.sequence();
      workBoardDto.setWorkNo(workNo);
      
      if(workBoardVO.getAttachList() != null) {
    	  workBoardVO.getAttachList().forEach(attach -> System.out.print(attach));
      }
      workBoardService.write(workBoardDto, workBoardVO);
      rttr.addFlashAttribute("result", workBoardVO.getWorkNo());
      
      
      return "redirect:/";
   }
   
   //업무일지 보고
   @GetMapping("/report")
   public String report(@RequestParam int workNo,
                   Model model) {
      model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));
      model.addAttribute("files", workFileRepo.selectAll(workNo));
      
      return "workboard/report";
   }
   
   @PostMapping("/report")
   public String report(@ModelAttribute WorkReportDto workReportDto,
                        @ModelAttribute WorkBoardDto workBoardDto,
                        @RequestParam int workNo,
                        HttpSession session,
                        @RequestParam List<String> supList) {

       for (String empNo : supList) {
           WorkReportDto dto = new WorkReportDto();
           dto.setWorkNo(workNo);
           dto.setWorkSup(empNo);
           workReportRepo.insert(dto);
       }
       return "redirect:/";
   }
   
   @GetMapping("/supList")
   public String supList(HttpSession session, Model model) {
       String workSup = (String) session.getAttribute("empNo");
       
       model.addAttribute("supList", workReportRepo.supList(workSup));
       
       return "workboard/supList";
   }

   
   @GetMapping("/reportList")
   public String reportList(HttpSession session,
		   				 Model model) {
	   String workSup = (String) session.getAttribute("empNo");
	   
	   List<ReportWithWorkBoardVO> reportList = workReportRepo.reportList(workSup);
	   model.addAttribute("reportList", reportList);
	   return "workboard/reportList";
   }
   
   
   //업무일지 목록
   @GetMapping("/list")
   public String list(Model model) {
       model.addAttribute("employees", employeeRepo.list());
       
      model.addAttribute("list", workBoardRepo.list());
      return "workboard/list";
   }
   
   //업무일지 수정
   @GetMapping("/edit")
   public String edit(@RequestParam int workNo,
                  Model model) {
      model.addAttribute("employees", employeeRepo.list());
      model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));
      
      model.addAttribute("files", workFileRepo.selectAll(workNo));
      return "workboard/edit";
   }
   
   @PostMapping("/edit")
   public String edit(@ModelAttribute WorkBoardDto workBoardDto,
                  @RequestParam int workNo,
                  @RequestParam("attachments") List<MultipartFile> attachments,
                  RedirectAttributes attr) throws IllegalStateException, IOException {
//      workBoardService.deleteFile(workNo);
      workBoardService.updateFile(workNo, attachments);
      
      workBoardRepo.update(workBoardDto);
      
      attr.addAttribute("workNo", workBoardDto.getWorkNo());
      return "redirect:detail";
   }
   
   //업무일지 상세
   @GetMapping("/detail")
   public String detail(@RequestParam int workNo,
                   Model model) {
      model.addAttribute("employees", employeeRepo.list());
      model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));
      
      model.addAttribute("files", workFileRepo.selectAll(workNo));
      return "workboard/detail";
   }
   
   
}