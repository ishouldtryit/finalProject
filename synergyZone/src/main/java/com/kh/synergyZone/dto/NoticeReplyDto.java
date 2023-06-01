package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class NoticeReplyDto {
	private int noticeReplyNo;
	private String noticeReplyWriter;
	private int noticeReplyOrigin;
	private String noticeReplyContent;
	private Date noticeReplyTime;
}
