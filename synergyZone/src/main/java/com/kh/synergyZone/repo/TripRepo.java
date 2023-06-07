package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.TripDto;

public interface TripRepo {
	void insert(TripDto tripDto);
	List<TripDto> list();
	
}
