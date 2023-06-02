package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatUserDto {
	private String roomName;
	private String empNo;
	private String empName;
	private Date joinTime;
}