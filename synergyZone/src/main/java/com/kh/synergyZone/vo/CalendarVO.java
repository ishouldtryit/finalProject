package com.kh.synergyZone.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CalendarVO {
	Integer seq;
	String content;
	String title;
	String empNo;
	String empName;
	String startDtm;
	String endDtm;
}
