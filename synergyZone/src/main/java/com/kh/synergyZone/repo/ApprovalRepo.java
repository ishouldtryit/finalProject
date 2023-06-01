package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.vo.ApprovalDataVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface ApprovalRepo {

	void insert(ApprovalDto approvalDto);	//등록
	int approvalDataCount(PaginationVO vo); // 전체 카운트
	List<ApprovalDataVO> selectList(PaginationVO vo);	//전체목록
	List<ApprovalDataVO> selectListDrafter(PaginationVO vo);	//기안자 기안서 목록
	ApprovalDto selectOne(int draftNo);	//상세
	void delete(int draftNo);	//삭제
	void edit(ApprovalDto approvalDto);	//수정
	void approverInsert(ApproverDto approverDto);	//결재자 등록
	void agreeorInsert(AgreeorDto agreeorDto);	//합의자 등록
	void recipientInsert(RecipientDto recipientDto);	//참조자 등록
	void readerInsert(ReaderDto readerDto);	//열람자 등록
	int approvalSequence();	//기안서 번호 생성
}
