package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.WorkFileDto;

public interface WorkFileRepo {
	void insert(WorkFileDto workFileDto);
	WorkFileDto selectOne(int workNo); 
	List<WorkFileDto> selectAll(int workNo);
	void delete(int attachmentNo);
	void editDelete(int attachmentNo);
	void update(int workNo);
}
