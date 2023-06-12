package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.JobDto;

@Repository
public class JobRepoImpl implements JobRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(JobDto jobDto) {
		sqlSession.insert("job.save", jobDto);
	}

	@Override
	public List<JobDto> list() {
		return sqlSession.selectList("job.list");
	}

	@Override
	public void delete(int jobNo) {
		sqlSession.delete("job.delete", jobNo);
	}

	@Override
	public JobDto name(int jobNo) {
		return sqlSession.selectOne("job.jobName",jobNo);
	} 
}
