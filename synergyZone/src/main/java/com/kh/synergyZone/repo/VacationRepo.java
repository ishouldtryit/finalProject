package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.VacationDto;
import com.kh.synergyZone.vo.VacationVO;

public interface VacationRepo {
	//연차사용 리스트
	List<VacationVO> selectList(VacationVO vo);
	//관리자 사용
	List<VacationVO> adminList();
	//대기열 
	List<VacationVO> queue(VacationVO vo);
	
	
	void insert(VacationVO vo);
	VacationVO oneList(int vacationNo);

}
