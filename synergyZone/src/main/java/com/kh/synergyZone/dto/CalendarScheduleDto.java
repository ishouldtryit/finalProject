package com.kh.synergyZone.dto;

import lombok.Data;

@Data
public class CalendarScheduleDto {
	private int schNo;
	private String empNum;
	private String calNo;
	private String schName;
	private String schStartDate;
	private String schStartTime;
	private String schEndDate;
	private String schEndTime;
	private String schContent;
	private String schCate;
	private String schColor;

	@Override
	public String toString() {
		return "CalendarScheduleDto [schNo=" + schNo + ", empNum=" + empNum + ", calNo=" + calNo + ", schName=" + schName
				+ ", schStartDate=" + schStartDate + ", schStartTime=" + schStartTime + ", schEndDate=" + schEndDate
				+ ", schEndTime=" + schEndTime + ", schContent=" + schContent + ", schCate=" + schCate + ", schColor="
				+ schColor + "]";
	}
	
}
