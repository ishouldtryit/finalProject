package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.WorkBoardDto;

public interface WorkBoardRepo {
	int sequence();
	void insert(WorkBoardDto workBoardDto);
//	WorkBoardDto workBoardDto 
}
