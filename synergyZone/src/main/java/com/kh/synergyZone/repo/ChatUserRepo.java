package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ChatUserDto;

public interface ChatUserRepo {
	void add(ChatUserDto dto);
	List<ChatUserDto> find(String memberId);
	boolean check(ChatUserDto userDto);
}