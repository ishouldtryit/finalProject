package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReplyDto {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Date replyTime;
}
