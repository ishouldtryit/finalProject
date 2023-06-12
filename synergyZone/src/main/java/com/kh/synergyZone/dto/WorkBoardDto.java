package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class WorkBoardDto {
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
	private int resultCode;
	private int statusCode;
}
