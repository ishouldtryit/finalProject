package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ChatRoomDto;

public interface ChatRoomRepo {
	int sequence();
	void create(ChatRoomDto dto);
	ChatRoomDto find(String roomName);
	List<ChatRoomDto> list();
}