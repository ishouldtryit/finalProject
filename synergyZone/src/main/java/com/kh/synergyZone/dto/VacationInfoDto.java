package com.kh.synergyZone.dto;

import lombok.Data;

@Data
public class VacationInfoDto {
	private String empNo;
	private int total;
	private int uesd;
	private int residual;
	
	private String empName;
	private String jobName;
	private int attachmentNo;
}
