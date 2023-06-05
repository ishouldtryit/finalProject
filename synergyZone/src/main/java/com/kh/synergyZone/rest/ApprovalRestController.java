package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;
import com.kh.synergyZone.repo.EmployeeRepoImpl;
import com.kh.synergyZone.vo.ApprovalPaginationVO;
import com.kh.synergyZone.vo.ApprovalVO;
import com.kh.synergyZone.vo.ApprovalWithPageVO;
import com.kh.synergyZone.vo.DeptEmpListVO;

@RestController
@RequestMapping("/rest/approval")
public class ApprovalRestController {

	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	@Autowired
	private ApprovalRepoImpl approvalRepoImpl;
	
	// 부서별 사원 목록
	@GetMapping("/")
	public List<DeptEmpListVO> list(@RequestParam String searchName){
		String empName = searchName;
		return employeeRepoImpl.treeSelect(empName);
	}
	
	@PostMapping("/write")
	public int write(@RequestBody ApprovalVO approvalVO, HttpSession session) {
		
		String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
		
		List<ApproverDto> approverList = approvalVO.getApproverList();
		List<AgreeorDto> agreeorList = approvalVO.getAgreeorList();
		List<RecipientDto> recipientList = approvalVO.getRecipientList();
		List<ReaderDto> readerList = approvalVO.getReaderList();
		
		int draftNo = approvalRepoImpl.approvalSequence();
	    int approverOrder = 1;
	    approvalVO.getApprovalDto().setDrafterNo(empNo);
	    approvalVO.getApprovalDto().setDraftNo(draftNo);
	    approvalRepoImpl.insert(approvalVO.getApprovalDto());	//기안서 등록
	    
	    for (ApproverDto approver : approverList) {	//결재자 등록
	        approver.setDraftNo(draftNo);
	        approver.setApproverOrder(approverOrder);
	        approverOrder++;
	        approvalRepoImpl.approverInsert(approver);
	    }
	    
	    for (AgreeorDto agreeor : agreeorList) {	//합의자 등록
	    	agreeor.setDraftNo(draftNo);
	    	approvalRepoImpl.agreeorInsert(agreeor);
	    }
	    
	    for (RecipientDto recipient : recipientList) {	//참조자 등록
	    	recipient.setDraftNo(draftNo);
	    	approvalRepoImpl.recipientInsert(recipient);
	    }
	    
	    for (ReaderDto reader : readerList) {	//열람자 등록
	    	reader.setDraftNo(draftNo);
	    	approvalRepoImpl.readerInsert(reader);
	    }
	    return draftNo;
	}
	
		//목록 첫화면 (관리자)
		@GetMapping("/adminList")
		public ApprovalWithPageVO adminDraftList(ApprovalPaginationVO vo){
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setCount(approvalRepoImpl.approvalDataCount(vo));
		    ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
		            .approvalDataVO(approvalRepoImpl.approvalDataSelectList(listPagination))
		            .paginationVO(listPagination)
		            .build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (관리자)
		@PostMapping("/adminMoveList")
		public ApprovalWithPageVO adminMoveList(@RequestBody ApprovalPaginationVO vo) {
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.approvalDataCount(vo));
		    ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
		            .approvalDataVO(approvalRepoImpl.approvalDataSelectList(listPagination))
		            .paginationVO(listPagination)
		            .build();
			return approvalWithPageVO;			
		}
		
		//목록 첫화면 (기안자)
		@GetMapping("/myList")
		public ApprovalWithPageVO myDraftList(ApprovalPaginationVO vo, HttpSession session){
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setCount(approvalRepoImpl.myApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.myApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (기안자)
		@PostMapping("/myMoveList")
		public ApprovalWithPageVO myMoveList(@RequestBody ApprovalPaginationVO vo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.myApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.myApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;			
		}
		
		//목록 첫화면 (결재대기자)
		@GetMapping("/waitApproverList")
		public ApprovalWithPageVO waitApproverList(ApprovalPaginationVO vo, HttpSession session){
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setCount(approvalRepoImpl.waitApproverApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.waitApproverApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (결재대기자)
		@PostMapping("/waitApproverMoveList")
		public ApprovalWithPageVO waitApproverMoveList(@RequestBody ApprovalPaginationVO vo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.waitApproverApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.waitApproverApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;			
		}
		
		//목록 첫화면 (합의대기자)
		@GetMapping("/waitAgreeorList")
		public ApprovalWithPageVO waitAgreeorList(ApprovalPaginationVO vo, HttpSession session){
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setCount(approvalRepoImpl.waitAgreeorApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.waitAgreeorApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (합의대기자)
		@PostMapping("/waitAgreeorMoveList")
		public ApprovalWithPageVO waitAgreeorMoveList(@RequestBody ApprovalPaginationVO vo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.waitAgreeorApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.waitAgreeorApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;			
		}
		
		//목록 첫화면 (참조문서)
		@GetMapping("/recipientList")
		public ApprovalWithPageVO recipientList(ApprovalPaginationVO vo, HttpSession session){
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setCount(approvalRepoImpl.recipientApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.recipientApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (참조문서)
		@PostMapping("/recipientMoveList")
		public ApprovalWithPageVO recipientMoveList(@RequestBody ApprovalPaginationVO vo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.recipientApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.recipientApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;			
		}
		
		//목록 첫화면 (열람문서)
		@GetMapping("/readerList")
		public ApprovalWithPageVO readerList(ApprovalPaginationVO vo, HttpSession session){
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setCount(approvalRepoImpl.readerApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.readerApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;
		}
		
		//페이지 이동&검색 (열람문서)
		@PostMapping("/readerMoveList")
		public ApprovalWithPageVO readerMoveList(@RequestBody ApprovalPaginationVO vo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			vo.setLoginUser(empNo);
			ApprovalPaginationVO listPagination = new ApprovalPaginationVO();
			listPagination.setLoginUser(empNo);
			listPagination.setColumn(vo.getColumn());
			listPagination.setKeyword(vo.getKeyword());
			listPagination.setPageStatus(vo.getPageStatus());
			listPagination.setIsemergency(vo.isIsemergency());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.readerApprovalDataCount(vo));
			ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
					.approvalDataVO(approvalRepoImpl.readerApprovalDataSelectList(listPagination))
					.paginationVO(listPagination)
					.build();
			return approvalWithPageVO;			
		}
		
		

		
	
}
