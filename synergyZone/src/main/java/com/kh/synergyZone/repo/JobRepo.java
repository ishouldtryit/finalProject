package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.JobDto;

public interface JobRepo {
	void insert(JobDto jobDto);
	List<JobDto> list();
	void delete(int jobNo);
}
