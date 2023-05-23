package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class readerDto {
	private String readerNo;
	private int draftNo;
	private int readerOrder;
}
