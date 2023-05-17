package com.kh.synergyZone.dto;

import lombok.Data;

@Data
public class CalendarBookMarkDto {
	private String calNo;
	private int schNo;
	private String empNo;
	private String calName;
	private String empName;
	private String empDivision;
	private String empRank;
	private char cStatus;

	@Override
	public String toString() {
		return "CalendarBookMarkDto [calNo=" + calNo + ", schNo=" + schNo + ", empNo=" + empNo + ", calName=" + calName
				+ ", empName=" + empName + ", empDivision=" + empDivision + ", empRank=" + empRank + ", cStatus="
				+ cStatus + "]";
	}
	
}
