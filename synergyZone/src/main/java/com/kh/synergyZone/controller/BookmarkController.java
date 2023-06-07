package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.BookmarkDto;
import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.BookmarkRepo;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;
import com.kh.synergyZone.service.EmployeeService;
import com.kh.synergyZone.vo.BookmarkVO;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/bookmark")
public class BookmarkController {
   
   @Autowired 
   private EmployeeRepo employeeRepo;
   
   @Autowired 
   private AttachmentRepo attachmentRepo;
   
   @Autowired 
   private CustomFileUploadProperties fileuploadProperties;
   
   @Autowired
   private EmployeeService employeeService;
   
   @Autowired
   private EmployeeProfileRepo employeeProfileRepo;
   
   @Autowired
   private DepartmentRepo departmentRepo;
   
   @Autowired
   private JobRepo jobRepo;
   
   @Autowired
   private BookmarkRepo bookmarkRepo;
   
   // 관리자 홈
   @GetMapping("/")
   public String home() {
      return "bookmark";
   }
   
   // 즐겨찾기한 사원 목록
   @GetMapping("/mylist")
   public String myList(Model model, @ModelAttribute("vo") PaginationVO vo, HttpSession session,
		   			@RequestParam(required = false, defaultValue = "") String empNo,
                        @RequestParam(required = false, defaultValue = "1") int page,
                        @RequestParam(required = false, defaultValue = "") String sort,
                        @RequestParam(required = false, defaultValue = "") String column,
                        @RequestParam(required = false, defaultValue = "") String keyword) throws IOException {

       // 즐겨찾기한 사원들 띄우기
       String ownerNo = (String) session.getAttribute("empNo");
       List<BookmarkDto> bookmarkList = bookmarkRepo.getMyList(ownerNo);
       model.addAttribute("bookmarkList", bookmarkList);

       List<EmployeeInfoDto> employees;

       // 검색
       if (!column.isEmpty() && !keyword.isEmpty()) {
    	   employees = employeeService.searchEmployees(column, keyword);
       } else {
           employees = employeeRepo.list();
       }
       if (empNo != null) {
    	    model.addAttribute("profile", employeeProfileRepo.find(empNo));
    	}
       
       

       // 페이징 처리
       int totalCount = bookmarkRepo.checkOwnerCount(ownerNo); // 전체 데이터 개수
       vo.setCount(totalCount); // PaginationVO 객체의 count 값을 설정

       int size = vo.getSize(); // 페이지당 표시할 데이터 개수
       int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
       int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

       List<EmployeeInfoDto> pagedEmployees = employees.subList(startIndex, Math.min(endIndex, employees.size()));

       // 직위, 부서별 조회
       List<DepartmentDto> departments = departmentRepo.list();
       List<JobDto> jobs = jobRepo.list();

       model.addAttribute("departments", departments);
       model.addAttribute("jobs", jobs);
       model.addAttribute("column", column);
       model.addAttribute("employees", pagedEmployees);

       // 페이지 정보 추가
       int totalPage = (int) Math.ceil((double) totalCount / size); // 전체 페이지 개수
       int startPage = ((page - 1) / 10) * 10 + 1; // 시작 페이지 번호
       int endPage = Math.min(startPage + 9, totalPage); // 끝 페이지 번호

       model.addAttribute("startPage", startPage);
       model.addAttribute("endPage", endPage);
       model.addAttribute("totalPage", totalPage);
       model.addAttribute("currentPage", page);

       return "bookmark/mylist";
   }

   
   //나만의 즐겨찾기 추가하기 
   @PostMapping("/addBookmark")
   @ResponseBody
   public void addBookmark(@RequestBody BookmarkVO vo, HttpSession session) {
       String ownerNo = (String) session.getAttribute("empNo");

       for (String bookmarkNo : vo.getBookmarkNo()) {
           // 중복 체크
           if (!bookmarkRepo.existsBookmark(ownerNo, bookmarkNo)) {
               BookmarkDto bookmarkDto = new BookmarkDto();
               bookmarkDto.setOwnerNo(ownerNo);
               bookmarkDto.setBookmarkNo(bookmarkNo);
               bookmarkRepo.addToMyList(bookmarkDto);
           }
       }
   }

   @PostMapping("/removeBookmark")
   @ResponseBody
   public void removeBookmark(@RequestBody BookmarkVO vo) {
       for (String bookmarkNo : vo.getBookmarkNo()) {
           bookmarkRepo.removeFromBookmark(bookmarkNo);
       }
   }
   
   @PostMapping("/getMyList")
   @ResponseBody
   public List<BookmarkDto> getMyList(HttpSession session) {
       String ownerNo = (String) session.getAttribute("empNo");
       return bookmarkRepo.getMyList(ownerNo);
   }
   
    
}