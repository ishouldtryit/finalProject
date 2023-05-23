package com.kh.synergyZone.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class BoardDto {
	private int boardNo;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private Date boardTime;
	private String boardHead;
	private int boardRead;
	private int boardLike;
	private int boardReply;
	private int boardGroup, boardDepth;
	private Integer boardParent;//null이 가능하므로
	
	//가상의 Getter를 추가하여 현재시각을 기준으로 비교 후
	//1. 날짜가 같으면 시간과 분을 반환	(HH:mm)
	//2. 날짜가 다르면 연/월/일을 반환	(yyyy-MM-dd)
	public String getBoardTimeAuto() {
		//현재 시각을 java.sql.Date 형태로 구한다
		java.util.Date now = new java.util.Date();
		java.util.Date write = new java.util.Date(boardTime.getTime());
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		String nowStr = f.format(now);//형식이 변환된 현재시각
		String writeStr = f.format(write);//형식이 변환된 작성시각
		
		if(nowStr.substring(0, 10).equals(writeStr.substring(0, 10))) {//현재일자 == 작성일자
			return writeStr.substring(11);//"HH:mm"
		}
		else {
			return writeStr.substring(0, 10);//"yyyy-MM-dd"
		}
	}

	//새글인지 여부를 확인하는 명령
	public boolean isNew() {
		return boardParent == null;
	}
	//답글인지 여부를 확인하는 명령
	public boolean isAnswer() {
		//return boardParent != null;
		return !isNew();
	}
}







