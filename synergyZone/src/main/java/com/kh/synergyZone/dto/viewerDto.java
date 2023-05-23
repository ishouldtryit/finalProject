package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class viewerDto {
	private String viewerNo;
	private int draftNo;
	private int viewerOrder;
}
