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

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;
import com.kh.synergyZone.dto.WorkFileDto;
import com.kh.synergyZone.dto.WorkReportDto;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.repo.WorkFileRepo;
import com.kh.synergyZone.repo.WorkReportRepo;
import com.kh.synergyZone.service.WorkBoardService;
import com.kh.synergyZone.vo.PaginationVO;

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
 		return "workboard/write";
 	}
 	
 	
 	@PostMapping("/write")
 	public String write(@ModelAttribute WorkBoardDto workBoardDto,
 						HttpSession session,
 						@RequestParam("attachments") List<MultipartFile> attachments) throws IllegalStateException, IOException {
 		String empNo = (String) session.getAttribute("empNo");
 		workBoardDto.setEmpNo(empNo);
 		
 		int workNo = workBoardRepo.sequence();
 		workBoardDto.setWorkNo(workNo);
 		
// 		System.out.println(workBoardDto.getWorkSecret());
 		
 		workBoardService.write(workBoardDto, attachments);
 		
 		
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
                        @RequestParam List<String> supList,
                        RedirectAttributes attr) {

       for (String empNo : supList) {
           WorkReportDto dto = new WorkReportDto();
           dto.setWorkNo(workNo);
           dto.setWorkSup(empNo);
           workReportRepo.insert(dto);
       }
       
       attr.addAttribute("workNo", workNo);
       return "redirect:detail";
   }
   
   //참조자 보관함
   @GetMapping("/supList")
   public String supList(HttpSession session, Model model) {
       String workSup = (String) session.getAttribute("empNo");
       model.addAttribute("supList", workReportRepo.supList(workSup));
       return "workboard/supList";
   }

   //내 보관함
   @GetMapping("/myWorkList")
   public String reportList(HttpSession session,
		   					@ModelAttribute("vo") PaginationVO vo,
						    @RequestParam(required = false, defaultValue = "") String column,
				            @RequestParam(required = false, defaultValue = "") String keyword,
		   				    Model model) {
	   
	   String empNo = (String) session.getAttribute("empNo");
	   
	   List<WorkEmpInfo> myWorkList;
	   
	   //검색
	   if(!column.isEmpty() && !keyword.isEmpty()) {
		   myWorkList = workBoardRepo.SearchMyWorkList(column, keyword);
	   } else {
		   myWorkList = workBoardRepo.myWorkList(empNo);
	   }
	   
	   //페이징
	   int totalCount = myWorkList.size();
	   vo.setCount(totalCount);
	   
	   int size = vo.getSize();  // 페이지당 표시할 데이터 개수
       int page = vo.getPage();  // 현재 페이지 번호
       
       int startIndex = (page - 1) * size;  // 데이터의 시작 인덱스
       int endIndex = Math.min(startIndex + size, totalCount);  // 데이터의 종료 인덱스
       
       List<WorkEmpInfo> pagedMyWorkList = myWorkList.subList(startIndex, endIndex);
       
	   
	   //selected 유지
       model.addAttribute("column", column);
       
       model.addAttribute("myWorkList", pagedMyWorkList);
	   
	   return "workboard/myWorkList";
   }
   
   
   //업무일지 목록
   @GetMapping("/list")
   public String list(HttpSession session, Model model) {
	   String jobNo = (String) session.getAttribute("jobNo");
	   
       model.addAttribute("employees", employeeRepo.list());
       
      model.addAttribute("list", workBoardRepo.list(0));
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
                  @RequestParam("attachmentList") List<Integer> deleteList,                  
                  RedirectAttributes attr) throws IllegalStateException, IOException {

      // 기존 DB내에서 해당값과 맞으면 삭제시키고 아니면 버림
      

      List<WorkFileDto> files = workFileRepo.selectAll(workNo); //DB값 찾고
      workBoardService.updateFile(workNo, attachments);
      workBoardRepo.update(workBoardDto);
      
      //2중 for문
      for (Integer no : deleteList) {
    	  //no값 들어올때마다 
    	  for (WorkFileDto file : files) {
    		  System.out.println("삭제리스트"+no);
    		  System.out.println("파일리스트"+file.getAttachmentNo());
    		  //no값과 files의 attachmentNo의 값이 동일한지 확인
            if(no.equals(file.getAttachmentNo())) {
            	System.out.println("실제삭제"+no);
               workBoardService.deleteFile(no,workNo);//파일삭제
            }
         }
      }
      

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