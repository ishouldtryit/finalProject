package com.kh.synergyZone.vo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalWithDrafterDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApprovalDataVO {

	private ApprovalWithDrafterDto approvalWithDrafterDto;	//기안서+기안자 Dto
	private List<ApproverDto> approverList ;	//결재자 데이터 리스트
	private List<AgreeorDto> agreeorList ;		//합의자 데이터 리스트
	private List<RecipientDto> recipientList ;		//참조자 데이터 리스트
	private List<ReaderDto> readerList ;		//열람자 데이터 리스트

}
