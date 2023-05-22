package com.kh.synergyZone.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LoginRecordSearchVO {
	private String empNo;
	private String empName;
	private Integer searchLoginDays;
	
	public boolean isSearch() {
		return searchLoginDays != null && empName != null;
	}
	
}
