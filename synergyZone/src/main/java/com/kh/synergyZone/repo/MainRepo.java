package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.dto.NoticeDto;

public interface MainRepo {
	List<MessageWithNickDto> msg(String empNo);
	List<BoardDto> free();
	List<NoticeDto> notice();
}
