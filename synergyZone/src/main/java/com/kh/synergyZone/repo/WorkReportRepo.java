package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.SupWithWorkDto;
import com.kh.synergyZone.dto.WorkReportDto;

public interface WorkReportRepo {
	void insert(WorkReportDto workReportDto);
	List<WorkReportDto> list();
	List<SupWithWorkDto> supList(String workSup);
}

