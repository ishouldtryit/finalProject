package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.SupWithWorkDto;
import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;

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
	public List<SupWithWorkDto> list() {
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

	//내 업무일지
	@Override
	public List<WorkEmpInfo> myWorkList(String empNo) {
		return sqlSession.selectList("workBoard.myWorkList", empNo);
	}

	@Override
	public List<WorkEmpInfo> SearchMyWorkList(String column, String keyword) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("column", column);
		 params.put("keyword", keyword);
		 return sqlSession.selectList("workBoard.SearchMyWorkList",params);
	}

	
	
}
