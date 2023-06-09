package com.kh.synergyZone.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

import com.kh.synergyZone.dto.SupWithWorkDto;
import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;
import com.kh.synergyZone.dto.WorkFileDto;
import com.kh.synergyZone.dto.WorkReportDto;
import com.kh.synergyZone.repo.AttachmentRepo;
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
	private AttachmentRepo attachmentRepo;

	@Autowired
	private WorkReportRepo workReportRepo;

	// 업무일지 작성
	@GetMapping("/write")
	public String write(Model model) {
		return "/workboard/write";
	}

	@PostMapping("/write")
	public String write(@ModelAttribute WorkBoardDto workBoardDto, HttpSession session,
						@RequestParam("attachments") List<MultipartFile> attachments,
						RedirectAttributes attr) throws IllegalStateException, IOException {
		String empNo = (String) session.getAttribute("empNo");
		workBoardDto.setEmpNo(empNo);

		int workNo = workBoardRepo.sequence();
		workBoardDto.setWorkNo(workNo);


		workBoardService.write(workBoardDto, attachments);
		
		attr.addAttribute("workNo", workNo);

		return "redirect:detail";
	}

	// 업무일지 보고
	@GetMapping("/report")
	public String report(@RequestParam int workNo, Model model, HttpSession session) {
		model.addAttribute("employees", employeeRepo.list());
		model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));

		model.addAttribute("files", workFileRepo.selectAll(workNo));
		model.addAttribute("workSups", workReportRepo.selectAll(workNo));
		
		// 글 작성자 판단
		WorkEmpInfo workBoardDto = workBoardRepo.selectOne(workNo);
		String empNo = (String) session.getAttribute("empNo");
		boolean owner = workBoardDto.getEmpNo() != null && workBoardDto.getEmpNo().equals(empNo);
		model.addAttribute("owner", owner);

		// 관리자 판단
		String empAdmin = (String) session.getAttribute("empAdmin");
		boolean admin = empAdmin != null && empAdmin.equals("Y");
		model.addAttribute("admin", admin);


		return "/workboard/report";
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

	
	// 결재
	@GetMapping("/sign")
	public String sign(@RequestParam int workNo, Model model, HttpSession session) {
		model.addAttribute("employees", employeeRepo.list());
		model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));

		model.addAttribute("files", workFileRepo.selectAll(workNo));
		model.addAttribute("workSups", workReportRepo.selectAll(workNo));

		return "/workboard/sign";
	}

	@PostMapping("/sign")
	public String sign(@ModelAttribute WorkReportDto workReportDto,
	                   @RequestParam int workNo,
	                   HttpSession session,
	                   RedirectAttributes attr) {
	    WorkBoardDto workBoardDto = workBoardRepo.selectOnly(workNo);
	    workBoardRepo.signedCount(workBoardDto.getWorkNo());

	    workBoardService.updateResult(workNo);

	    attr.addAttribute("workNo", workNo);

	    return "redirect:detail";
	}
	
	@GetMapping("/workReturn")
	public String workReturn(@RequestParam int workNo, RedirectAttributes attr) {
	    WorkBoardDto workBoardDto = workBoardRepo.selectOnly(workNo);
	    workBoardRepo.workReturn(workBoardDto);
	    attr.addAttribute("workNo", workNo);
	    return "redirect:detail";
	}

	
	


	// 참조자 보관함
	@GetMapping("/supList")
	public String supList(@ModelAttribute("vo") PaginationVO vo,
	                      @RequestParam(required = false, defaultValue = "") String column,
	                      @RequestParam(required = false, defaultValue = "") String keyword, 
	                      HttpSession session, Model model) {
	    String workSup = (String) session.getAttribute("empNo");
	    
	    List<SupWithWorkDto> supList;
	    
	    // 검색
	    if (!column.isEmpty() && !keyword.isEmpty()) {
	        supList = workReportRepo.searchSupList(column, keyword, workSup);
	    } else {
	        supList = workReportRepo.supList(workSup);
	    }
	    
	    // 중복 제거를 위한 Set 생성
	    Set<Integer> uniqueWorkNoSet = new HashSet<>();
	    
	    // 중복 제거된 결과를 담을 리스트
	    List<SupWithWorkDto> filteredSupList = new ArrayList<>();
	    
	    // 중복 제거 로직 수행
	    for (SupWithWorkDto dto : supList) {
	        int workNo = dto.getWorkNo();
	        if (!uniqueWorkNoSet.contains(workNo)) {
	            uniqueWorkNoSet.add(workNo);
	            filteredSupList.add(dto);
	        }
	    }

	    // 페이징
	    int totalCount = filteredSupList.size();
	    vo.setCount(totalCount);

	    int size = vo.getSize(); // 페이지당 표시할 데이터 개수
	    int page = vo.getPage(); // 현재 페이지 번호

	    int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
	    int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

	    List<SupWithWorkDto> pagedSupList = filteredSupList.subList(startIndex, endIndex);

	    // selected 유지
	    model.addAttribute("column", column);

	    model.addAttribute("supList", pagedSupList);


	    return "/workboard/supList";
	}


	// 내 보관함
	@GetMapping("/myWorkList")
	public String reportList(HttpSession session, @ModelAttribute("vo") PaginationVO vo,
							 @RequestParam(required = false, defaultValue = "") String column,
							 @RequestParam(required = false, defaultValue = "") String keyword, 
							 Model model) {

		String empNo = (String) session.getAttribute("empNo");

		List<WorkEmpInfo> myWorkList;

		// 검색
		if (!column.isEmpty() && !keyword.isEmpty()) {
			myWorkList = workBoardRepo.SearchMyWorkList(column, keyword, empNo);
		} else {
			myWorkList = workBoardRepo.myWorkList(empNo);
		}

		// 페이징
		int totalCount = myWorkList.size();
		vo.setCount(totalCount);

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<WorkEmpInfo> pagedMyWorkList = myWorkList.subList(startIndex, endIndex);
		
		 // 업무 상태 수와 참조자 수 계산
	    for (WorkEmpInfo work : pagedMyWorkList) {
	        int statusCount = work.getStatusCode();
	        int supCount = workBoardRepo.countSupList(work.getWorkNo());

	        work.setStatusCount(statusCount);
	        work.setSupCount(supCount);
	    }

		// selected 유지
		model.addAttribute("column", column);

		model.addAttribute("myWorkList", pagedMyWorkList);
		

		return "/workboard/myWorkList";
	}

	// 부서 업무일지
	@GetMapping("/list")
	public String list(HttpSession session, Model model, @ModelAttribute("vo") PaginationVO vo,
			@RequestParam(required = false, defaultValue = "member_regdate desc") String sort,
			@RequestParam(required = false, defaultValue = "") String column,
			@RequestParam(required = false, defaultValue = "") String keyword) {

		int deptNo = (int) session.getAttribute("deptNo");
		String empNo = (String) session.getAttribute("empNo");
		String empAdmin = (String) session.getAttribute("empAdmin");

		List<WorkEmpInfo> workList;

		if (!column.isEmpty() && !keyword.isEmpty()) {
			// 검색인 경우
			if (empAdmin != null && empAdmin.equals("Y")) {
				// 관리자인 경우, 모든 부서의 업무일지를 가져옴
				workList = workBoardRepo.SearchlistByJobNoWithSecret(column, keyword, empNo, deptNo);
			} else {
				// 작성자인 경우, 자신의 비밀글을 포함한 업무일지를 가져옴
				workList = workBoardRepo.SearchlistByJobNoWithSecret(column, keyword, empNo, deptNo);
			}
		} else {
			// 검색이 아닌 경우
			if (empAdmin != null && empAdmin.equals("Y")) {
				// 관리자인 경우, 모든 부서의 업무일지를 가져옴
				workList = workBoardRepo.list(deptNo);
			} else {
				// 작성자인 경우, 자신의 비밀글을 포함한 업무일지를 가져옴
				workList = workBoardRepo.listByJobNoWithSecret(deptNo, empNo);
			}
		}

		// 페이징
		int totalCount = workList.size();
		vo.setCount(totalCount);

		int size = vo.getSize(); // 페이지당 표시할 데이터 개수
		int page = vo.getPage(); // 현재 페이지 번호

		int startIndex = (page - 1) * size; // 데이터의 시작 인덱스
		int endIndex = Math.min(startIndex + size, totalCount); // 데이터의 종료 인덱스

		List<WorkEmpInfo> pagedWorkList = workList.subList(startIndex, endIndex);

		// selected 유지
		model.addAttribute("column", column);

		model.addAttribute("list", pagedWorkList);

		return "/workboard/list";
	}

	// 업무일지 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int workNo, Model model) {
		model.addAttribute("employees", employeeRepo.list());
		model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));

		model.addAttribute("files", workFileRepo.selectAll(workNo));
		return "/workboard/edit";
	}

	  @PostMapping("/edit")
	   public String edit(@ModelAttribute WorkBoardDto workBoardDto,
	                  @RequestParam int workNo,
	                  @RequestParam("attachments") List<MultipartFile> attachments,
	                  @RequestParam("attachmentList") List<Integer> deleteList, //해당 부분추가 deleteList값 받아옴                  
	                  RedirectAttributes attr) throws IllegalStateException, IOException {

	      // 기존 DB내에서 해당값과 맞으면 삭제시키고 아니면 버림
	      List<WorkFileDto> files = workFileRepo.selectAll(workNo); //DB에서 파일리스트 불러옴
	      //기존업데이트 그대로진행
	      workBoardService.updateFile(workNo, attachments);
	      workBoardRepo.update(workBoardDto);

	      //service에서 기존코드는 업무번호를 받는것으로 되어있어서 파일번호를 받게 변경
	      //기존처럼 업무번호를 받으면 해당 업무번호의 파일전체를 삭제하게 되버림 --> DB구문 workNo가 아닌 attachmentNo를 받아서 단일로 찾도록 변경
	      //아래는 단일로 찾은 attachmentNo를 이중for문을 돌려서 정확하게 일치시 삭제하는 문장

	      //2중 for문
	      for (Integer no : deleteList) {
	    	  //no값 들어올때마다 
	    	  for (WorkFileDto file : files) {
	    		  //삭제리스트 no값과 DB리스트 files의 attachmentNo의 값이 동일한지 확인
	    		  //만약 동일하다면
	            if(no.equals(file.getAttachmentNo())) {
	            	//파일번호와 업무번호를 보내서 삭제
	               workBoardService.deleteFile(no,workNo);//파일삭제
	            }
	         }
	      }

	      attr.addAttribute("workNo", workBoardDto.getWorkNo());
	      return "redirect:detail";
	   }

	// 업무일지 상세
	@GetMapping("/detail")
	public String detail(@RequestParam int workNo,
//						 @RequestParam(required = false, defaultValue = "") String empNo,
			Model model, HttpSession session) {
		model.addAttribute("employees", employeeRepo.list());
		model.addAttribute("workBoardDto", workBoardRepo.selectOne(workNo));

		model.addAttribute("files", workFileRepo.selectAll(workNo));
		model.addAttribute("workSups", workReportRepo.selectAll(workNo));

		// 글 작성자 판단
		WorkEmpInfo workBoardDto = workBoardRepo.selectOne(workNo);
		String empNo = (String) session.getAttribute("empNo");
		boolean owner = workBoardDto.getEmpNo() != null && workBoardDto.getEmpNo().equals(empNo);
		model.addAttribute("owner", owner);

		// 관리자 판단
		String empAdmin = (String) session.getAttribute("empAdmin");
		boolean admin = empAdmin != null && empAdmin.equals("Y");
		model.addAttribute("admin", admin);

		return "/workboard/detail";
	}

	// 업무일지 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int workNo) {

		// 첨부파일 삭제
		List<WorkFileDto> workFileDto = workFileRepo.selectAll(workNo);

		if (workFileDto != null && !workFileDto.isEmpty()) {
			for (WorkFileDto fileDto : workFileDto) {
				int attachmentNo = fileDto.getAttachmentNo();
				// 첨부파일 삭제
				attachmentRepo.delete(attachmentNo);
			}
		}

		// 첨부파일 관련 데이터 삭제
		workFileRepo.delete(workNo);

		// 게시물 삭제
		workBoardRepo.delete(workNo);

		return "redirect:list";
	}


}