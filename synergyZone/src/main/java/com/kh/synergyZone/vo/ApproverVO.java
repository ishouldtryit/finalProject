package com.kh.synergyZone.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApproverVO {

	private String approverNo;	//결재자 사원번호
	private int draftNo;	//기안서 번호
	private int approverOrder;	//결재 순서
	private int approved;	//결재 여부
	private int returned;	//반려 여부
	private String returnReason;	//반려 사유
	private String approvalReason;	//결재 사유
	private String empName;
    private String empEmail;
    private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;
    private int cpNumber;
    private int deptNo;
    private Integer attachmentNo;
    private int jobNo;
    private String jobName;
    private String empNo;
    private String deptName;
	
}
