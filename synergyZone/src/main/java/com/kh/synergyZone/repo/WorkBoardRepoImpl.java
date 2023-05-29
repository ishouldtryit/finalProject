package com.kh.synergyZone.repo;

import java.util.List;

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

	@Override
	public List<WorkBoardDto> list() {
		return sqlSession.selectList("workBoard.list");
	}

	@Override
	public WorkBoardDto selectOne(int workNo) {
		return sqlSession.selectOne("workBoard.find", workNo);
	}

	@Override
	public void update(WorkBoardDto workBoardDto) {
		sqlSession.update("workBoard.edit", workBoardDto);
	}

	
	
}