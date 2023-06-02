package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ChatMessageDto;

public interface ChatMessageRepo {
	void add(ChatMessageDto dto);
	List<ChatMessageDto> roomMessageList(String roomName);
}