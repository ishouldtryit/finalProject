package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class VacationInfoDto {
	private String empNo;
	private int total;
	private int used;
	private int residual;
	
	private String empName;
	private String jobName;
	private int attachmentNo;
	private Date empHireDate;
}
