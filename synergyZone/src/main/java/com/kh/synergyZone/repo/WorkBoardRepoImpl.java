package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.WorkBoardDto;

@Repository
public class WorkBoardRepoImpl implements WorkBoardRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("workBoard.sequence");
	}
	
	@Override
	public void insert(WorkBoardDto workBoardDto) {
		sqlSession.insert("workBoard.save", workBoardDto);
	}

	
	
}
