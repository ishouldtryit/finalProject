package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.vo.LoginRecordSearchVO;

public interface LoginRecordRepo {
	void insert(LoginRecordDto loginRecordDto);
	List<LoginRecordDto> list();
	List<LoginRecordDto> logList(LoginRecordSearchVO vo);
}
