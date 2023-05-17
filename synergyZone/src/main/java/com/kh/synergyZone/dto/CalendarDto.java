package com.kh.synergyZone.dto;

import lombok.Data;

@Data
public class CalendarDto {
	private int calNo;
	private int schNo;
	private String empNo;
	private String calName;
	private String empName;
	private String empDivision;
	private String empRank;

	@Override
	public String toString() {
		return "CalendarDto [calNo=" + calNo + ", schNo=" + schNo + ", empNo=" + empNo + ", calName=" + calName
				+ ", Name=" + empName + ", empDivision=" + empDivision + ", empRank=" + empRank + "]";
	}
	
	
}