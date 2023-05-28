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
	private int useCount;
	private int stauts;
	private String reason;
	
	//받아온값
	private String selectedValue;
}
