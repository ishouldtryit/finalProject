package com.kh.synergyZone.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReplyVO {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Date replyTime;
	private String empName;
    private String empEmail;
    private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;
    private int cpNumber;
    private int jobNo;
    private int deptNo;
    private int attachmentNo;
    private String jobName;
    private String deptName;
    private String empNo;

}
