package com.kh.synergyZone.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class NoticeReplyVO {
	private int noticeReplyNo;
	private String noticeReplyWriter;
	private int noticeReplyOrigin;
	private String noticeReplyContent;
	private Date noticeReplyTime;
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
