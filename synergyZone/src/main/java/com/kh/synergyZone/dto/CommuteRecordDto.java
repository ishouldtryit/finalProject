package com.kh.synergyZone.dto;

import java.sql.Date;
import java.time.Duration;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommuteRecordDto {
	private String empNo;
	private String startTime;
	private String endTime;
	
	@DateTimeFormat(pattern = "HH:mm:ss")
	private Duration workTime;
	
	private Date workDate;
	
}
