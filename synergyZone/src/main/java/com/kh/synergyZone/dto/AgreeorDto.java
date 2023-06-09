package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class AgreeorDto {
	private String agreeorNo;	//합의자 사원번호
	private int agreeorOrder;	//합의자 순서
	private int draftNo;	//기안서 번호
}
