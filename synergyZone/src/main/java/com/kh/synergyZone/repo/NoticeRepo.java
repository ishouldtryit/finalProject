package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.NoticeDto;
import com.kh.synergyZone.vo.PaginationVO;

public interface NoticeRepo {
	List<NoticeDto> selectList();
	List<NoticeDto> selectList(String column, String keyword);
	NoticeDto selectOne(int noticeNo);
	int sequence();
	void insert(NoticeDto noticeDto);
	boolean delete(int noticeNo);
	boolean update(NoticeDto noticeDto);
	boolean updateNoticeReadcount(int noticeNo);
	int selectCount(PaginationVO vo);
	List<NoticeDto> selectList(PaginationVO vo);
	void updateNoticeLikecount(int noticeNo, int count);
	void updateNoticeReplycount(int noticeNo);
	void connect(int noticeNo, int attachmentNo);
}