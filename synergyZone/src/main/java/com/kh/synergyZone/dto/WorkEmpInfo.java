package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class WorkEmpInfo {
	private int workNo;
	private String empNo;
	private String workTitle;
	private String workContent;
	private Date workStart;
	private Date workDeadline;
	private int workStatus;
	private Date workReportDate;
	private String workSecret;
	private String workType;
	private String empName;
	private int jobNo;
	private int deptNo;
	private int attachmentNo;
	private int resultCode;
	private int statusCode;
	
	 private int statusCount; // 업무 상태 수
	 private int supCount; // 참조자 수

}
