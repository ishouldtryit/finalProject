package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.synergyZone.dto.JobDto;

public class JobRepoImpl implements JobRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(JobDto jobDto) {
		sqlSession.insert("job.save", jobDto);
	} 
}
