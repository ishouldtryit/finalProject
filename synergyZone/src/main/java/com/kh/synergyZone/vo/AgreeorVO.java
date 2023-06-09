package com.kh.synergyZone.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class AgreeorVO {

	private String agreeorNo;	//합의자 사원번호
	private int agreeorOrder;	//합의자 순서
	private int draftNo;	//기안서 번호
	private String empName;
    private String empEmail;
    private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;
    private String empAdmin;
    private int cpNumber;
    private int deptNo;
    private Integer attachmentNo;
    private int jobNo;
    private String jobName;
    private String empNo;
    private String deptName;
	
}
