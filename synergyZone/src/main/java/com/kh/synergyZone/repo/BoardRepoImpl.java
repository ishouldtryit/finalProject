package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.vo.PaginationVO;


@Repository
public class BoardRepoImpl implements BoardRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<BoardDto> selectNoticeList(int begin, int end) {
		Map<String, Object> param = new HashMap<>();
		param.put("begin", begin);
		param.put("end", end);
		return sqlSession.selectList("Board.selectNoticeList", param);
	}

	@Override
	public List<BoardDto> selectList() {
		return sqlSession.selectList("Board.selectList");
	}

	@Override
	public List<BoardDto> selectList(String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("Board.selectList", param);
	}

	@Override
	public BoardDto selectOne(int boardNo) {
		return sqlSession.selectOne("Board.selectOne",boardNo);
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("Board.sequence");
	}

	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("Board.insert", boardDto);
	}

	@Override
	public boolean delete(int boardNo) {
		int result = sqlSession.delete("Board.delete", boardNo);
		return result > 0;
	}

	@Override
	public boolean update(BoardDto boardDto) {
		int result = sqlSession.update("Board.update",boardDto);
		return result > 0;
	}

	@Override
	public boolean updateReadcount(int boardNo) {
		int result = sqlSession.update("updateReadcount", boardNo);
		return result > 0;
	}
	@Override
	public void updateLikecount(int boardNo, int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("count", count);
		sqlSession.update("Board.updateLikecount", param);
	}


	@Override
	public void updateReplycount(int boardNo) {
		sqlSession.update("Board.updateReplycount", boardNo);
	}

	@Override
	public void connect(int boardNo, int attachmentNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("attachmentNo", attachmentNo);
		sqlSession.insert("Board.connect", param);
	}

	@Override
	public int selectCount(PaginationVO vo) {
		return sqlSession.selectOne("Board.selectCount", vo);
	}

	@Override
	public List<BoardDto> selectList(PaginationVO vo) {
		return sqlSession.selectList("Board.selectList", vo);
	}
	

}