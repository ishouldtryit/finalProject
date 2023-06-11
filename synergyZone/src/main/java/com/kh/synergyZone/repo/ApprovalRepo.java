package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApprovalWithDrafterDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.vo.AgreeorVO;
import com.kh.synergyZone.vo.ApprovalDataVO;
import com.kh.synergyZone.vo.ApprovalPaginationVO;
import com.kh.synergyZone.vo.ApproverVO;
import com.kh.synergyZone.vo.ReaderVO;
import com.kh.synergyZone.vo.RecipientVO;

public interface ApprovalRepo {

	void insert(ApprovalDto approvalDto);	//등록
	int approvalDataCount(ApprovalPaginationVO vo); // 전체 카운트(관리자)
	List<ApprovalDataVO> approvalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(관리자)
	int myApprovalDataCount(ApprovalPaginationVO vo); // 전체 카운트(기안자)
	List<ApprovalDataVO> myApprovalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(기안자)
	int waitApproverApprovalDataCount(ApprovalPaginationVO vo); // 전체 카운트(결재대기자)
	List<ApprovalDataVO> waitApproverApprovalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(결재대기자)
	int waitAgreeorApprovalDataCount(ApprovalPaginationVO vo); // 전체 카운트(합의대기자)
	List<ApprovalDataVO> waitAgreeorApprovalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(합의대기자)
	int recipientApprovalDataCount(ApprovalPaginationVO vo); // 전체 카운트(참조문서)
	List<ApprovalDataVO> recipientApprovalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(참조문서)
	int readerApprovalDataCount(ApprovalPaginationVO vo); // 전체 카운트(열람문서)
	List<ApprovalDataVO> readerApprovalDataSelectList(ApprovalPaginationVO vo);	//전체 목록(열람문서)
	ApprovalDataVO approvalDataSelectOne(int draftNo); //상세 페이지 정보
	ApprovalDto draftSelectOne(int draftNo); //기안서 정보
	int approverCount(int draftNo); //결재자 수 카운트
	void delete(int draftNo);	//삭제
	void edit(ApprovalWithDrafterDto approvalWithDrafterDto);	// 기안서 수정 등록
	void approverEdit(ApproverVO approverVO);	//결재자 수정 등록
	void agreeorEdit(AgreeorVO agreeorVO);	//합의자 수정 등록
	void recipientEdit(RecipientVO recipientVO);	//참조자 수정 등록
	void readerEdit(ReaderVO readerVO);	//열람자 수정 등록
	void recallApproval(int draftNo);	// 기안서 회수
	void reApproval(int draftNo);	// 기안서 회수
	void draftApproval(ApproverDto approverDto); //기안서 결재
	void draftApprovalReason(ApproverDto approverDto); //기안서 결재 의견
	void draftCompletedDate(int draftNo); // 결재 완료일
	void approved(ApproverDto approverDto); //결재 최종 완료
	void draftReturn(ApproverDto approverDto); //결재 반려
	void draftReturnReason(ApproverDto approverDto); //결재 반려 의견
	void approverInsert(ApproverDto approverDto);	//결재자 등록
	void agreeorInsert(AgreeorDto agreeorDto);	//합의자 등록
	void recipientInsert(RecipientDto recipientDto);	//참조자 등록
	void readerInsert(ReaderDto readerDto);	//열람자 등록
	int approvalSequence();	//기안서 번호 생성
}
