package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.TripPersonDto;

public interface TripPersonRepoImpl {
	void insert(TripPersonDto personDto);
	List<TripPersonDto> list();
}
