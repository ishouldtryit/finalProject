package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.SupWithWorkDto;
import com.kh.synergyZone.dto.WorkEmpInfo;
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
	public List<WorkEmpInfo> list(String jobNo) {
		return sqlSession.selectList("workReport.list", jobNo);
	}
	
	//보고받은 업무일지
	@Override
	public List<SupWithWorkDto> supList(String workSup) {
		return sqlSession.selectList("workReport.supList", workSup);
	}


}
