package com.kh.synergyZone.dto;

import java.sql.Date;
import java.time.Duration;

import lombok.Data;

@Data
public class CommuteRecordDto {
	private String empNo;
	private String startTime;
	private String endTime;
	private Duration work_time;
	private Date workDate;
	
}
