package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.VacationDto;

public interface VacationRepo {

	List<VacationDto> selectList();

}
