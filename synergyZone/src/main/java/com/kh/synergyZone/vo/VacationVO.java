package com.kh.synergyZone.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class VacationVO {
	private String vacationNo;
	private String empNo;
	private String vacationName;
	private Date startDate;
	private Date endDate;
	private Date usedDate;
	private double useCount;
	private int status;
	private String reason;
	private int leave;
	
	private String empName;
	private String deptName;
	private String deptNo;
	
	
	//받아온값
	private String selectedValue;
}
