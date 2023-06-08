package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.NoticeReplyDto;
import com.kh.synergyZone.vo.NoticeReplyVO;


@Repository
public class NoticeReplyRepoImpl implements NoticeReplyRepo {

	
	@Autowired
	private SqlSession sqlSession;

    @Autowired
    public NoticeReplyRepoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }


    @Override
    public void insert(NoticeReplyDto noticeReplyDto) {
        sqlSession.insert("noticeReply.insert", noticeReplyDto);
    }

    @Override
    public List<NoticeReplyVO> selectList(int noticeReplyOrigin) {
        return sqlSession.selectList("noticeReply.selectList", noticeReplyOrigin);
    }

    @Override
    public void update(NoticeReplyDto noticeReplyDto) {
        sqlSession.update("noticeReply.update", noticeReplyDto);
    }

    @Override
    public void delete(int noticeReplyNo) {
        sqlSession.delete("noticeReply.delete", noticeReplyNo);
    }

    @Override
    public NoticeReplyVO selectOne(int noticeReplyNo) {
        return sqlSession.selectOne("noticeReply.selectOne", noticeReplyNo);
    }
}
