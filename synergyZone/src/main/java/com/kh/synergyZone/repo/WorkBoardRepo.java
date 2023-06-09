package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;
import com.kh.synergyZone.dto.WorkReportDto;

public interface WorkBoardRepo {
	int sequence();
	void insert(WorkBoardDto workBoardDto);
	List<WorkEmpInfo> list(int deptNo);
	WorkBoardDto selectOnly(int workNo);
	WorkEmpInfo selectOne(int workNo);
	void update(WorkBoardDto workBoardDto);
	void delete(int workNo);
	
	//부서 업무일지 비밀글
	List<WorkEmpInfo> listByJobNoWithSecret(int deptNo, String empNo);
	
	//부서 업무일지 검색
	List<WorkEmpInfo> SearchlistByJobNoWithSecret(String column, String keyword, String empNo, int deptNo);
	
	//내 업무일지
	List<WorkEmpInfo> myWorkList(String empNo);
	
	
	//내 업무일지 검색
	List<WorkEmpInfo> SearchMyWorkList(String column, String keyword, String empNo);
	
	// 결재
	void signed(WorkBoardDto workBoardDto);

	void workReturn(WorkBoardDto workBoardDto);

	int signedCount(int workNo);
	
	//결재 결과
	int countSupList(int workNo);
//	int statusCode(int workNo);
}
