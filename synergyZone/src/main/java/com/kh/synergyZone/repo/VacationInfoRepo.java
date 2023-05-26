package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.VacationInfo;

public interface VacationInfoRepo {
	//연차등록
	void add(VacationInfo info);
	//사원 연차조회
	VacationInfo one(String empNo);
	//연차사용시
	void used(VacationInfo info);
	//스케쥴링 사용시
	void scheduling(VacationInfo info);
	
	
}
