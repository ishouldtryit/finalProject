package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkEmpInfo;
import com.kh.synergyZone.dto.WorkReportDto;

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
	public List<WorkEmpInfo> list(int deptNo) {
		return sqlSession.selectList("workBoard.list", deptNo);
	}

	@Override
	public WorkEmpInfo selectOne(int workNo) {
		return sqlSession.selectOne("workBoard.find", workNo);
	}

	@Override
	public void update(WorkBoardDto workBoardDto) {
		sqlSession.update("workBoard.edit", workBoardDto);
	}

	@Override
	public void delete(int workNo) {
		sqlSession.delete("workBoard.delete", workNo);
	}
	
	//내 업무일지
	@Override
	public List<WorkEmpInfo> myWorkList(String empNo) {
		return sqlSession.selectList("workBoard.myWorkList", empNo);
	}

	@Override
	public List<WorkEmpInfo> SearchMyWorkList(String column, String keyword, String empNo) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("column", column);
		 params.put("keyword", keyword);
		 params.put("empNo", empNo);
		 return sqlSession.selectList("workBoard.searchMyWorkList", params);
	}

	@Override
	public List<WorkEmpInfo> listByJobNoWithSecret(int deptNo, String empNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("deptNo", deptNo);
        params.put("empNo", empNo);
        return sqlSession.selectList("workBoard.listByJobNoWithSecret", params);
    }

	@Override
	public List<WorkEmpInfo> SearchlistByJobNoWithSecret(String column, String keyword, String empNo, int deptNo) {
		Map<String, Object> params = new HashMap<>();
		 params.put("column", column);
		 params.put("keyword", keyword);
		 params.put("empNo", empNo);
		 params.put("deptNo", deptNo);
		 return sqlSession.selectList("workBoard.searchListByJobNoWithSecret", params);
	}
	
	// 결재 승인
	@Override
	public void signed(WorkBoardDto workBoardDto) {
		sqlSession.update("workBoard.signed", workBoardDto);
	}

	// 반려
	@Override
	public void workReturn(WorkBoardDto workBoardDto) {
		sqlSession.update("workBoard.workReturn", workBoardDto);
	}

	// 결재 승인 카운트
	@Override
	public int signedCount(int workNo) {
		Integer count = sqlSession.selectOne("workBoard.signedCount", workNo);
	    return (count != null) ? count.intValue() : 0;
	}

	@Override
	public WorkBoardDto selectOnly(int workNo) {
		return sqlSession.selectOne("workBoard.findOnly", workNo);
	}

	@Override
	public int countSupList(int workNo) {
		return sqlSession.selectOne("workBoard.countSupList", workNo);
	}

//	@Override
//	public int statusCode(int workNo) {
//		return sqlSession.selectOne("workBoard.statusCode", workNo);
//	}

	
	
}
