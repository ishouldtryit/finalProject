package com.kh.synergyZone.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

// 메세지 수신 양식
//type = 1일 경우 채팅 메세지로 간주하며 chatMessageContent 항목이 필요
//type = 2일 경우 입장 메세지로 간주하며 chatRoomNo 항목 필요
@Data @JsonIgnoreProperties
public class ChatReceiveVO {

	//방이동인지 메세지인지 
	private int type;
	//메세지내용
	private String content;
	//방번호
	private String roomNo;

	
}