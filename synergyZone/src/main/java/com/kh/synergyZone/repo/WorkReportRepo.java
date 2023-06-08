package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.SupWithWorkDto;
import com.kh.synergyZone.dto.WorkReportDto;
import com.kh.synergyZone.vo.ReportWithWorkBoardVO;

public interface WorkReportRepo {
	void insert(WorkReportDto workReportDto);
	List<WorkReportDto> list();
	List<SupWithWorkDto> supList(String workSup);
	List<ReportWithWorkBoardVO> reportList(String workSup);
}
