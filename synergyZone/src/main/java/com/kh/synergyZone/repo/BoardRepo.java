package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.vo.PaginationVO;

public interface BoardRepo {
	List<BoardDto> selectNoticeList(int begin, int end);
	List<BoardDto> selectList();
	List<BoardDto> selectList(String column, String keyword);
	BoardDto selectOne(int boardNo);
	int sequence();
	void insert(BoardDto boardDto);
	boolean delete(int boardNo);
	boolean update(BoardDto boardDto);
	boolean updateReadcount(int boardNo);
	int selectCount(PaginationVO vo);
	List<BoardDto> selectList(PaginationVO vo);
	void updateLikecount(int boardNo, int count);
	void updateReplycount(int boardNo);
	void connect(int boardNo, int attachmentNo);
}