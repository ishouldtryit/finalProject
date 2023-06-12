package com.kh.synergyZone.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApprovalWithDrafterDto {
	
	private int draftNo;			//기안서 번호
	private String draftTitle;		//기안서 제목 
	private String draftContent;	//기안서 내용
	private Date draftDate;			//기안서 작성일
	private Date completionDate; //기안 완료일
	private String drafterNo;		//기안서 작성자
	private int statusCode;			//결재 상태 코드
	private int resultCode;			//결재 결과 코드
	private String returnReson;		//반려 사유
	private int isemergency;		//긴급 문서 유무
	private String empEmail;
	private String empName;
	private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;	
    private String empAdmin;	
    private int cpNumber;
    private int jobNo;
    private int deptNo;
    private Integer attachmentNo;
    private String jobName;
    private String deptName;
    
    public String getDraftDateForm() {
    	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd0-HH:mm");
    	java.util.Date date = new java.util.Date(draftDate.getTime());
    	return f.format(date).substring(2,10);
    }
    
    public String getCompletionDateForm() {
    	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd0-HH:mm");
    	if(completionDate == null) {
    		return null;
    	}
    	java.util.Date date = new java.util.Date(completionDate.getTime());
    	return f.format(date).substring(2,10);
    }
    
}
