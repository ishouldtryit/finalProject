package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.repo.ApprovalRepoImpl;
import com.kh.synergyZone.repo.EmployeeRepoImpl;
import com.kh.synergyZone.vo.ApprovalVO;
import com.kh.synergyZone.vo.DeptEmpListVO;

import lombok.extern.slf4j.Slf4j;

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
	
	//	@GetMapping("/list")
	//	public List<ApprovalVO> draftList(){
	//		approvalRepoImpl.selectList();
	//		
	//		return 
	//	}
	
}
