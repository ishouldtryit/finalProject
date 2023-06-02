package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatMessageDto {
	private int msgNo;
	private String empNo;
	private String empName;
	private String roomName;
	private String msgBody;
	private Date msgTime;
}