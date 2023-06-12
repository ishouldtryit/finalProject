package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.dto.LoginRecordInfoDto;
import com.kh.synergyZone.vo.LoginRecordSearchVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface LoginRecordRepo {
	void insert(LoginRecordDto loginRecordDto);
	List<LoginRecordInfoDto> list();
//	List<LoginRecordInfoDto> logList(LoginRecordSearchVO vo);
	
	int selectCount(PaginationVO vo);
	List<LoginRecordInfoDto> selectListByPaging(PaginationVO vo);
	
}
