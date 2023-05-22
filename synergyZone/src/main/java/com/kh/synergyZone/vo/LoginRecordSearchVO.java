package com.kh.synergyZone.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LoginRecordSearchVO {
	private String empName;
//	private String beginLogDate;
//	private String endLogDate;
	private Integer searchLoginDays;
	
}
