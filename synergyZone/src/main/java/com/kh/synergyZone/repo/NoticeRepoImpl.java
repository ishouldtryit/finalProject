package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.vo.NoticeVO;
import com.kh.synergyZone.vo.PaginationVO;


@Repository
public class NoticeRepoImpl implements NoticeRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeVO> selectNoticeList(int begin, int end) {
		Map<String, Object> param = new HashMap<>();
		param.put("begin", begin);
		param.put("end", end);
		return sqlSession.selectList("Notice.selectNoticeList", param);
	}

	@Override
	public List<NoticeVO> selectList() {
		return sqlSession.selectList("Notice.selectList");
	}

	@Override
	public List<NoticeVO> selectList(String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("Notice.selectList", param);
	}

	@Override
	public NoticeVO selectOne(int noticeNo) {
		return sqlSession.selectOne("Notice.selectOne",noticeNo);
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("Notice.sequence");
	}

	@Override
	public void insert(NoticeVO noticeVO) {
		sqlSession.insert("Notice.insert", noticeVO);
	}

	@Override
	public boolean delete(int noticeNo) {
		int result = sqlSession.delete("Notice.delete", noticeNo);
		return result > 0;
	}

	@Override
	public boolean update(NoticeVO noticeVO) {
		int result = sqlSession.update("Notice.update",noticeVO);
		return result > 0;
	}

	@Override
	public boolean updateNoticeReadcount(int noticeNo) {
		int result = sqlSession.update("Notice.updateReadNoticecount", noticeNo);
		return result > 0;
	}
	@Override
	public void updateLikecount(int noticeNo, int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeNo", noticeNo);
		param.put("count", count);
		sqlSession.update("Notice.updateLikecount", param);
	}


	@Override
	public void updateReplycount(int noticeNo) {
		sqlSession.update("Notice.updateReplycount", noticeNo);
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
	public List<NoticeVO> selectList(PaginationVO vo) {
		return sqlSession.selectList("Notice.selectList", vo);
	}

	@Override
	public List<NoticeVO> selectListByPaging(PaginationVO vo) {
		return sqlSession.selectList("Notice.selectListByPaging", vo);
	}
	

}