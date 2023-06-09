package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
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
import com.kh.synergyZone.vo.AgreeorVO;
import com.kh.synergyZone.vo.ApprovalDataVO;
import com.kh.synergyZone.vo.ApprovalPaginationVO;
import com.kh.synergyZone.vo.ApprovalVO;
import com.kh.synergyZone.vo.ApprovalWithPageVO;
import com.kh.synergyZone.vo.ApproverVO;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.ReaderVO;
import com.kh.synergyZone.vo.RecipientVO;

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
	
	// 기안서 작성
	@PostMapping("/write")
	public int write(@RequestBody ApprovalVO approvalVO, HttpSession session) {
		
		String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
		
		List<ApproverDto> approverList = approvalVO.getApproverList();
		List<AgreeorDto> agreeorList = approvalVO.getAgreeorList();
		List<RecipientDto> recipientList = approvalVO.getRecipientList();
		List<ReaderDto> readerList = approvalVO.getReaderList();
		
		int draftNo = approvalRepoImpl.approvalSequence();
	    int approverOrder = 1;
	    int agreeorOrder = 1;
	    int recipientOrder = 1;
	    int readerOrder = 1;
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
	    	agreeor.setAgreeorOrder(agreeorOrder);
	    	agreeorOrder++;
	    	approvalRepoImpl.agreeorInsert(agreeor);
	    }
	    
	    for (RecipientDto recipient : recipientList) {	//참조자 등록
	    	recipient.setDraftNo(draftNo);
	    	recipient.setRecipientOrder(recipientOrder);
	    	recipientOrder++;
	    	approvalRepoImpl.recipientInsert(recipient);
	    }
	    
	    for (ReaderDto reader : readerList) {	//열람자 등록
	    	reader.setDraftNo(draftNo);
	    	reader.setReaderOrder(readerOrder);
	    	readerOrder++;
	    	approvalRepoImpl.readerInsert(reader);
	    }
	    return draftNo;
	}
	
	// 기안서 수정
	@PostMapping("/edit/{draftNo}")
	public int edit(@PathVariable int draftNo ,@RequestBody ApprovalDataVO approvalDataVO, HttpSession session) {
		String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");

		//기존 기안서 삭제
		int oldDraftNo = draftNo;
		approvalRepoImpl.delete(oldDraftNo);
		
		List<ApproverVO> approverList = approvalDataVO.getApproverList();
		List<AgreeorVO> agreeorList = approvalDataVO.getAgreeorList();
		List<RecipientVO> recipientList = approvalDataVO.getRecipientList();
		List<ReaderVO> readerList = approvalDataVO.getReaderList();
		int newDraftNo = approvalRepoImpl.approvalSequence();
		int approverOrder = 1;
	    int agreeorOrder = 1;
	    int recipientOrder = 1;
	    int readerOrder = 1;
		approvalDataVO.getApprovalWithDrafterDto().setDrafterNo(empNo);
		approvalDataVO.getApprovalWithDrafterDto().setDraftNo(newDraftNo);
		approvalRepoImpl.edit(approvalDataVO.getApprovalWithDrafterDto());	//기안서 등록
		
		for (ApproverVO approver : approverList) {	//결재자 등록
			approver.setDraftNo(newDraftNo);
			approver.setApproverOrder(approverOrder);
			approverOrder++;
			approvalRepoImpl.approverEdit(approver);
		}
		
		for (AgreeorVO agreeor : agreeorList) {	//합의자 등록
			agreeor.setDraftNo(newDraftNo);
			agreeor.setAgreeorOrder(agreeorOrder);
			agreeorOrder++;			
			approvalRepoImpl.agreeorEdit(agreeor);
		}
		
		for (RecipientVO recipient : recipientList) {	//참조자 등록
			recipient.setDraftNo(newDraftNo);
			recipient.setRecipientOrder(recipientOrder);
			recipientOrder++;			
			approvalRepoImpl.recipientEdit(recipient);
		}
		
		for (ReaderVO reader : readerList) {	//열람자 등록
			reader.setDraftNo(newDraftNo);
			reader.setReaderOrder(readerOrder);
			readerOrder++;			
			approvalRepoImpl.readerEdit(reader);
		}
		return newDraftNo;
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
		
		//상세 페이지
		@GetMapping("/detail/{draftNo}")
		public ApprovalDataVO approvalDetail(@PathVariable int draftNo, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			ApprovalDataVO approvalDataVO = approvalRepoImpl.approvalDataSelectOne(draftNo);
			approvalDataVO.setLoginUser(empNo);
			return approvalDataVO;
		}

		//문서 회수
		@PatchMapping("/recall/{draftNo}")
		public void approvalRecall(@PathVariable int draftNo) {
			approvalRepoImpl.recallApproval(draftNo);
		}
		
		//재기안
		@PatchMapping("/reApproval/{draftNo}")
		public void reApproval(@PathVariable int draftNo) {
			approvalRepoImpl.reApproval(draftNo);
		}
		
		//결재
		@PatchMapping("/draftApproval/{draftNo}")
		public void approved (@PathVariable int draftNo, @RequestBody ApproverDto dto, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			dto.setApproverNo(empNo);
			dto.setDraftNo(draftNo);
			approvalRepoImpl.draftApproval(dto);	//결재 승인
			approvalRepoImpl.draftApprovalReason(dto);	//결재 의견
			
			int statusCode = approvalRepoImpl.draftSelectOne(draftNo).getStatusCode();
			int approverCount = approvalRepoImpl.approverCount(draftNo);
			if(statusCode==approverCount) {	//결재 완료
				approvalRepoImpl.approved(dto);
			}
		}
		
		//반려
		@PatchMapping("/draftReturn/{draftNo}")
		public void returned (@PathVariable int draftNo, @RequestBody ApproverDto dto, HttpSession session) {
			String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
			dto.setApproverNo(empNo);
			dto.setDraftNo(draftNo);
			approvalRepoImpl.draftReturn(dto);	//결재 승인
			approvalRepoImpl.draftReturnReason(dto);	//결재 의견
		}
	
}
