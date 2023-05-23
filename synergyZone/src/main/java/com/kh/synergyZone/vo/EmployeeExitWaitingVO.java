package com.kh.synergyZone.vo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EmployeeExitWaitingVO {
	private List<EmployeeDto> waitingList;
}
