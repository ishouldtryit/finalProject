package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.NoticeDto;
import com.kh.synergyZone.vo.PaginationVO;


@Repository
public class NoticeRepoImpl implements NoticeRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeDto> selectList() {
		return sqlSession.selectList("Notice.selectList");
	}

	@Override
	public List<NoticeDto> selectList(String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("Notice.selectList", param);
	}

	@Override
	public NoticeDto selectOne(int noticeNo) {
		return sqlSession.selectOne("Notice.selectOne",noticeNo);
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("Notice.sequence");
	}

	@Override
	public void insert(NoticeDto noticeDto) {
		sqlSession.insert("Notice.insert", noticeDto);
	}

	@Override
	public boolean delete(int noticeNo) {
		int result = sqlSession.delete("Notice.delete", noticeNo);
		return result > 0;
	}

	@Override
	public boolean update(NoticeDto noticeDto) {
		int result = sqlSession.update("Notice.update",noticeDto);
		return result > 0;
	}

	@Override
	public boolean updateNoticeReadcount(int noticeNo) {
		int result = sqlSession.update("updateNoticeReadcount", noticeNo);
		return result > 0;
	}
	@Override
	public void updateNoticeLikecount(int noticeNo, int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeNo", noticeNo);
		param.put("count", count);
		sqlSession.update("Notice.updateLikecount", param);
	}


	@Override
	public void updateNoticeReplycount(int noticeNo) {
		sqlSession.update("Notice.updateNoticeReplycount", noticeNo);
	}

	@Override
	public void connect(int noticeNo, int attachmentNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeNo", noticeNo);
		param.put("attachmentNo", attachmentNo);
		sqlSession.insert("Notice.connect", param);
	}

	@Override
	public int selectCount(PaginationVO vo) {
		return sqlSession.selectOne("Notice.selectCount", vo);
	}

	@Override
	public List<NoticeDto> selectList(PaginationVO vo) {
		return sqlSession.selectList("Notice.selectList", vo);
	}
	

}