package com.kh.synergyZone.vo;

import java.util.List;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.EmployeeDetailsDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApprovalDataVO {

	private ApprovalDto approvalDto;	//기안서 Dto
	private List<EmployeeDetailsDto> approverList ;	//결재자 데이터 리스트
	private List<EmployeeDetailsDto> agreeorList ;		//합의자 데이터 리스트
	private List<EmployeeDetailsDto> recipientList ;		//참조자 데이터 리스트
	private List<EmployeeDetailsDto> readerList ;		//열람자 데이터 리스트

}
