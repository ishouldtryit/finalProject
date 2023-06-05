package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.vo.ApprovalDataVO;
import com.kh.synergyZone.vo.ApprovalPaginationVO;

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
	ApprovalDto selectOne(int draftNo);	//상세
	void delete(int draftNo);	//삭제
	void edit(ApprovalDto approvalDto);	//수정
	void approverInsert(ApproverDto approverDto);	//결재자 등록
	void agreeorInsert(AgreeorDto agreeorDto);	//합의자 등록
	void recipientInsert(RecipientDto recipientDto);	//참조자 등록
	void readerInsert(ReaderDto readerDto);	//열람자 등록
	int approvalSequence();	//기안서 번호 생성
}
