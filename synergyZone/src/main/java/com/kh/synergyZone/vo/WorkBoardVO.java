package com.kh.synergyZone.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class WorkBoardVO {
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
	
	
	private List<WorkAttachVO> attachList;
}
