package com.kh.synergyZone.vo;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkReportDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReportWithWorkBoardVO {
	private WorkReportDto workReportDto;
	private WorkBoardDto workBoardDto;
}
