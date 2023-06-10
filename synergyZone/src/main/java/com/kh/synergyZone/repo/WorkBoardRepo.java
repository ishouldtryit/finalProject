package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;

public interface WorkBoardRepo {
	int sequence();
	void insert(WorkBoardDto workBoardDto);
	List<WorkEmpInfo> list(int deptNo);
	WorkBoardDto selectOne(int workNo);
	void update(WorkBoardDto workBoardDto);
	void delete(int workNo);
	
	//내 업무일지
	List<WorkEmpInfo> myWorkList(String empNo);
	
	//비밀글
	List<WorkEmpInfo> listByJobNoWithSecret(int deptNo, String empNo);
	
	//내 업무일지 검색
	List<WorkEmpInfo> SearchMyWorkList(String column, String keyword);
}
