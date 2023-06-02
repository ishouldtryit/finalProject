package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.CommuteRecordDto;

public interface CommuteRecordRepo {
	//출퇴근 등록
	void insert(CommuteRecordDto dto);
	boolean update(CommuteRecordDto dto);
	
	//조회
	 CommuteRecordDto today(String empNo);
	 List<CommuteRecordDto> allList(String empNo);
	 
	 
	
}
