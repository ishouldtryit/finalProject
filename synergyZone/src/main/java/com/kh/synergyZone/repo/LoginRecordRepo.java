package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.LoginRecordDto;

public interface LoginRecordRepo {
	void insert(LoginRecordDto loginRecordDto);
	List<LoginRecordDto> list();
}
