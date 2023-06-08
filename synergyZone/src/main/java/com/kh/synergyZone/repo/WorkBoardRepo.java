package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;

public interface WorkBoardRepo {
	int sequence();
	void insert(WorkBoardDto workBoardDto);
	List<WorkBoardDto> list();
	WorkBoardDto selectOne(int workNo);
	void update(WorkBoardDto workBoardDto);
	
	List<WorkEmpInfo> myWorkList(String empNo);
}
