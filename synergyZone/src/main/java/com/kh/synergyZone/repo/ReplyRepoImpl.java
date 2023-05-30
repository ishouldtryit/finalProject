package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.ReplyDto;


@Repository
public class ReplyRepoImpl implements ReplyRepo {

	
	@Autowired
	private SqlSession sqlSession;

    @Autowired
    public ReplyRepoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }


    @Override
    public void insert(ReplyDto replyDto) {
        sqlSession.insert("reply.insert", replyDto);
    }

    @Override
    public List<ReplyDto> selectList(int replyOrigin) {
        return sqlSession.selectList("reply.selectList", replyOrigin);
    }

    @Override
    public void update(ReplyDto replyDto) {
        sqlSession.update("reply.update", replyDto);
    }

    @Override
    public void delete(int replyNo) {
        sqlSession.delete("reply.delete", replyNo);
    }

    @Override
    public ReplyDto selectOne(int replyNo) {
        return sqlSession.selectOne("reply.selectOne", replyNo);
    }
}
