package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class CommuteRecordDto {
	private String empNo;
	private Date startTime;
	private Date endTime;
}
