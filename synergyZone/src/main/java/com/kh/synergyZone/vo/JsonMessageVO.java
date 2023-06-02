package com.kh.synergyZone.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties//해석할 때 항목이 없어도 이해해라
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class JsonMessageVO {
	private String content;
	private long time;
}