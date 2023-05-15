package com.kh.synergyZone.dto;

import lombok.Data;

@Data
public class CalendarMemberDto {
	private String empNum;
	private String calNo;
	private int schNo;
	private String calName;
	private String empName;
	private String empDivision;
	private String empRank;
	
	@Override
	public String toString() {
		return "CalendarmemberDto [empNum=" + empNum + ", calNo=" + calNo + ", schNo=" + schNo + ", calName=" + calName
				+ ", empName=" + empName + ", empDivision=" + empDivision + ", empRank=" + empRank + "]";
	}
		
}
