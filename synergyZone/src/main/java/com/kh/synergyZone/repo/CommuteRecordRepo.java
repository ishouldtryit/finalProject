package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.CommuteRecordDto;

public interface CommuteRecordRepo {
	void insert(CommuteRecordDto commuteRecordDto);
	boolean update(CommuteRecordDto commuteRecordDto);
}
