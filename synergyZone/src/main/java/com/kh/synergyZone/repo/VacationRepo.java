package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.vo.VacationVO;

public interface VacationRepo {
	//연차사용 리스트
	List<VacationVO> selectList(VacationVO vo);

}
