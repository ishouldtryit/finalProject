package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SupWithWorkDto {
	private int workNo;
	private String workSup;
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
	private int deptNo;
	private String deptName;
	private int statusCode;
	private int resultCode;
}
