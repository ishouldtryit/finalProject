package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.vo.WorkAttachVO;

@Repository
public class WorkAttachRepoImpl implements WorkAttachRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(WorkAttachVO workAttachVO) {
		sqlSession.insert("workAttach.insert", workAttachVO);
	}

	@Override
	public WorkAttachVO selectOne(int workNo) {
		return sqlSession.selectOne("workAttach.findByWorkNo", workNo);
	}
	
	@Override
	public void delete(String uuid) {
		sqlSession.delete("workAttach.delete", uuid);
	}

	
	
}
