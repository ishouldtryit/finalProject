package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.SupWithWorkDto;
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
	
	//보고받은 업무일지
	@Override
	public List<SupWithWorkDto> supList(String workSup) {
		return sqlSession.selectList("workReport.supList", workSup);
	}
	
	//참조자 표시
	@Override
	public List<WorkReportDto> selectAll(int workNo) {
		List<WorkReportDto> workSups = sqlSession.selectList("workReport.find", workNo);
		if(workSups != null && !workSups.isEmpty()) {
			return workSups;
		}
		return null;
	}

	@Override
	public List<SupWithWorkDto> searchSupList(String column, String keyword, String workSup) {
		Map<String, Object> params = new HashMap<>();
		 params.put("column", column);
		 params.put("keyword", keyword);
		 params.put("workSup", workSup);
		 return sqlSession.selectList("workBoard.searchSupList", params);
	}


}
