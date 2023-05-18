package com.kh.synergyZone.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LoginRecordDto {
	private String empNo;
	private Timestamp logLogin;
	private String logIp;
	private String logBrowser;

}
