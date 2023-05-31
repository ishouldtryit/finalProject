package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.vo.ApprovalDataVO;

public interface ApprovalRepo {

	void insert(ApprovalDto approvalDto);	//등록
	List<ApprovalDataVO> selectList();	//전체목록
	ApprovalDto selectOne(int draftNo);	//상세
	void delete(int draftNo);	//삭제
	void edit(ApprovalDto approvalDto);	//수정
	void approverInsert(ApproverDto approverDto);	//결재자 등록
	void agreeorInsert(AgreeorDto agreeorDto);	//합의자 등록
	void recipientInsert(RecipientDto recipientDto);	//참조자 등록
	void readerInsert(ReaderDto readerDto);	//열람자 등록
	int approvalSequence();	//기안서 번호 생성
}
