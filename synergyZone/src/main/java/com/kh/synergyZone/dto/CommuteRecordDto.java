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
	private Object workTime;
	private Date workDate;
	private String startIp;
	private String endIp;
	
}
