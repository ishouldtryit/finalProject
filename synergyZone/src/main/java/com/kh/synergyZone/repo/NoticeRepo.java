package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.vo.NoticeVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface NoticeRepo {
	List<NoticeVO> selectNoticeList(int begin, int end);
	List<NoticeVO> selectList();
	List<NoticeVO> selectList(String column, String keyword);
	NoticeVO selectOne(int noticeNo);
	int sequence();
	void insert(NoticeVO noticeVO);
	boolean delete(int noticeNo);
	boolean update(NoticeVO noticeVO);
	boolean updateNoticeReadcount(int noticeNo);
	int selectCount(PaginationVO vo);
	List<NoticeVO> selectList(PaginationVO vo);
	void updateLikecount(int noticeNo, int count);
	void updateReplycount(int noticeNo);
	void connect(int noticeNo, int attachmentNo);
	List<NoticeVO> selectListByPaging(PaginationVO vo);
}