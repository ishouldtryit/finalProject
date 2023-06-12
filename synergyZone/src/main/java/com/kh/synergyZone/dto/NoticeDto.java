package com.kh.synergyZone.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeNo;
	private String noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeTime;
	private int noticeRead;
	private int noticeLike;
	private int noticeReply;
	private int noticeGroup, noticeDepth;
	private Integer noticeParent;//null이 가능하므로
	
	//가상의 Getter를 추가하여 현재시각을 기준으로 비교 후
	//1. 날짜가 같으면 시간과 분을 반환	(HH:mm)
	//2. 날짜가 다르면 연/월/일을 반환	(yyyy-MM-dd)
	public String getNoticeTimeAuto() {
		if (noticeTime == null) {
	        return ""; // 또는 다른 기본값을 반환할 수도 있습니다.
	    }
		//현재 시각을 java.sql.Date 형태로 구한다
		java.util.Date now = new java.util.Date();
		java.util.Date write = new java.util.Date(noticeTime.getTime());
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
		return noticeParent == null;
	}
	//답글인지 여부를 확인하는 명령
	public boolean isAnswer() {
		//return noticeParent != null;
		return !isNew();
	}
}







