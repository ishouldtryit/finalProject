package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class VacationDto {
	private String vacationNo;
	private String empNo;
	private String vacationName;
	private Date startDate;
	private Date endDate;
	private int useCount;
	private String reason;
	private int stauts;
	private Date usedDate;
}
