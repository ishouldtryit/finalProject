package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.WorkReportDto;

@Repository
public class WorkReportRepoImpl implements WorkReportRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(WorkReportDto workReportDto) {
		sqlSession.insert("workReport.insert", workReportDto);
	}

	@Override
	public List<WorkReportDto> list() {
		return sqlSession.selectList("workReport.list");
	}
	
	
}