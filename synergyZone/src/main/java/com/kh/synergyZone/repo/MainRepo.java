package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageDto;
import com.kh.synergyZone.dto.NoticeDto;

public interface MainRepo {
	List<MessageDto> msg();
	List<BoardDto> free();
	List<NoticeDto> notice();
}
