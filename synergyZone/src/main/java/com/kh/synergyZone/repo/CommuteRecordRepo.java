package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.CommuteRecordDto;

public interface CommuteRecordRepo {
	//출퇴근 등록
	void insert(String empNo);
	boolean update(String empNo);
	
	//조회
	 CommuteRecordDto today(String empNo);
	 List<CommuteRecordDto> allList(String empNo);
	 
	 
	
}
