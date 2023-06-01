package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;
import com.kh.synergyZone.repo.EmployeeRepoImpl;
import com.kh.synergyZone.vo.ApprovalDataVO;
import com.kh.synergyZone.vo.ApprovalVO;
import com.kh.synergyZone.vo.ApprovalWithPageVO;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.PaginationVO;

@RestController
@RequestMapping("/rest/approval")
public class ApprovalRestController {

	@Autowired
	private EmployeeRepoImpl employeeRepoImpl;
	@Autowired
	private ApprovalRepoImpl approvalRepoImpl;
	
	
	@GetMapping("/")
	public List<DeptEmpListVO> list(){
		return employeeRepoImpl.treeSelect();
	}
	
	@PostMapping("/write")
	public int write(@RequestBody ApprovalVO approvalVO, HttpSession session) {
		
		String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
		
		List<ApproverDto> approverList = approvalVO.getApproverList();
		List<AgreeorDto> agreeorList = approvalVO.getAgreeorList();
		List<RecipientDto> recipientList = approvalVO.getRecipientList();
		List<ReaderDto> readerList = approvalVO.getReaderList();
		
		int draftNo = approvalRepoImpl.approvalSequence();
	    int order = 1;
	    approvalVO.getApprovalDto().setDrafterNo(empNo);
	    approvalVO.getApprovalDto().setDraftNo(draftNo);
	    approvalRepoImpl.insert(approvalVO.getApprovalDto());	//기안서 등록
	    
	    for (ApproverDto approver : approverList) {	//결재자 등록
	        approver.setDraftNo(draftNo);
	        approver.setApproverOrder(order);
	        order++;
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
		//목록 첫화면
		@GetMapping("/list")
		public ApprovalWithPageVO draftList(PaginationVO vo){
			PaginationVO listPagination = new PaginationVO();
			
			listPagination.setPage(1);
			listPagination.setSize(10);
			listPagination.setCount(approvalRepoImpl.approvalDataCount(vo));
			
		    ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
		            .approvalDataVO(approvalRepoImpl.selectList(listPagination))
		            .paginationVO(listPagination)
		            .build();
			return approvalWithPageVO;
		}
		
		//페이지 이동
		@PostMapping("/moveList")
		public ApprovalWithPageVO moveList(@RequestBody PaginationVO vo) {
			PaginationVO listPagination = new PaginationVO();
			System.out.println(vo.getPageStatus());
			listPagination.setPage(vo.getPage());
			listPagination.setSize(vo.getSize());
			listPagination.setCount(approvalRepoImpl.approvalDataCount(vo));
		    ApprovalWithPageVO approvalWithPageVO = ApprovalWithPageVO.builder()
		            .approvalDataVO(approvalRepoImpl.selectList(listPagination))
		            .paginationVO(listPagination)
		            .build();
			return approvalWithPageVO;			
		}
		
	
}
