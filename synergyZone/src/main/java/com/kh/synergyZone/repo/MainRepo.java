package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.NoticeVO;

public interface MainRepo {
	List<MessageWithNickDto> msg(String empNo);
	List<BoardVO> free();
	List<NoticeVO> notice();
}
