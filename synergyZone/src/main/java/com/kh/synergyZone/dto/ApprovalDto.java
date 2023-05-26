package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApprovalDto {
	
	private int draftNo;			//기안서 번호
	private String draftTitle;		//기안서 제목 
	private String draftContent;	//기안서 내용
	private Date draftDate;			//기안서 작성일
	private Date updateDate;		//기안서 수정일
	private String drafterId;		//기안서 작성자
	private int statusCode;			//결재 상태 코드
	private int resultCode;			//결재 결과 코드
	private String returnReson;		//반려 사유
	private int isemergency;		//긴급 문서 유무
	
	
}
