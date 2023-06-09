package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class WorkFileDto {
	private int workNo;
	private Integer attachmentNo;
	private String attachmentName;
	private String attachmentType;
	private long attachmentSize;

}
