package com.kh.synergyZone.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ApprovalWithPageVO {
	private List<ApprovalDataVO> approvalDataVO;
	private PaginationVO paginationVO;
}
