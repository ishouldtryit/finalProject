package com.kh.synergyZone.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.text.SimpleDateFormat;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CalendarVO {
	int seq;
	String content;
	String title;
	String emp_no;
	String emp_name;
	String start_dtm;
	String end_dtm;
}
