package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.kh.synergyZone.dto.TripPersonDto;

public interface TripPersonRepo {
	void insert(TripPersonDto personDto);
	List<TripPersonDto> list(int tripNo);
	String one(String empNo);
}
