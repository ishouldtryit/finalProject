package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.VacationInfoDto;

//사원 연차정보
public interface VacationInfoRepo {
	//연차등록
	void add(VacationInfoDto info);
	//사원 연차조회
	VacationInfoDto one(String empNo);
	//연차사용시
	boolean used(VacationInfoDto info);
	//스케쥴링 사용시
	boolean scheduling(VacationInfoDto info);
	
	
}
