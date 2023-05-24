package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.ApprovalDto;

@Repository
public class ApprovalRepoImpl implements ApprovalRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ApprovalDto approvalDto) {
		sqlSession.insert("approval.insert",approvalDto);
		
	}

	@Override
	public List<ApprovalDto> selectList() {
		return sqlSession.selectList("approval.selectList");
	}

	@Override
	public ApprovalDto selectOne(int draftNo) {
		return sqlSession.selectOne("approval.selectOne", draftNo);
	}

	@Override
	public void delete(int draftNo) {
		sqlSession.delete("approval.remove", draftNo);
	}

	@Override
	public void edit(ApprovalDto approvalDto) {
		sqlSession.update("approval.editAllInOne", approvalDto);
		
	}

}
