package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EmployeeDto {
	private String empNo;
	private String empName;
	private String empPassword;
	private String empEmail;
	private String empPhone;
	private String empAddress;
	private String empDetailAddress;
	private String empPostcode;
	private Date empHireDate;
	private String picPath;
	private String picName;
	private String isLeave;
	private int cpNumber;
	private String signPath;
	private String signFileName;
	private int jobNo;
	private int deptNo;
	private int wtCode;
	
}