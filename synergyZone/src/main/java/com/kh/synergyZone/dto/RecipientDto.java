package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class RecipientDto {
	private String recipientNo;	//참조자 사원번호
	private int recipientOrder;	//참조자 순서
	private int draftNo;	//기안서 번호
}
