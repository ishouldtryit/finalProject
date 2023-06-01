package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface BoardRepo {
	List<BoardVO> selectNoticeList(int begin, int end);
	List<BoardVO> selectList();
	List<BoardVO> selectList(String column, String keyword);
	BoardVO selectOne(int boardNo);
	int sequence();
	void insert(BoardVO BoardVO);
	boolean delete(int boardNo);
	boolean update(BoardVO BoardVO);
	boolean updateReadcount(int boardNo);
	int selectCount(PaginationVO vo);
	List<BoardVO> selectList(PaginationVO vo);
	void updateLikecount(int boardNo, int count);
	void updateReplycount(int boardNo);
	void connect(int boardNo, int attachmentNo);
}