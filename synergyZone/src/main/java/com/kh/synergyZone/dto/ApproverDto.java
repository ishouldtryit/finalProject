package com.kh.synergyZone.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApproverDto {
	private String approverNo;	//결재자 사원번호
	private int draftNo;	//기안서 번호
	private int approverOrder;	//결재 순서
	private String returnReason; // 반려 사유
	private String approvalReason; // 승인 사유
	private int returned; // 반려 여부
	private int approved; // 승인 여부
}
