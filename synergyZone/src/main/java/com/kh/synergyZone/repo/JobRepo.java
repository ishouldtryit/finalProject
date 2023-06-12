package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.JobDto;

public interface JobRepo {
	void insert(JobDto jobDto);
	List<JobDto> list();
	void delete(int jobNo);
	
	//세션에서 검색해줄거
	JobDto name(int jobNo);
}
