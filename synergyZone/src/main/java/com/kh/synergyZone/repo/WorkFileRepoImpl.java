package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.WorkFileDto;

@Repository
public class WorkFileRepoImpl implements WorkFileRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(WorkFileDto workFileDto) {
		sqlSession.insert("workFile.insertFile", workFileDto);
	}
	
	
}
