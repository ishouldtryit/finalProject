package com.kh.synergyZone.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//사용자에게 좋아요의 결과를 알려주기 위한 클래스
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class NoticeLikeVO {
	private boolean result;
	private int count;
}
