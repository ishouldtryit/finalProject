package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.AgreeorDto;
import com.kh.synergyZone.dto.ApprovalDto;
import com.kh.synergyZone.dto.ApproverDto;
import com.kh.synergyZone.dto.ReaderDto;
import com.kh.synergyZone.dto.RecipientDto;
import com.kh.synergyZone.vo.ApprovalDataVO;

@Repository
public class ApprovalRepoImpl implements ApprovalRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ApprovalDto approvalDto) {
		sqlSession.insert("approval.insert",approvalDto);
	}

	@Override
	public List<ApprovalDataVO> selectList() {
		return sqlSession.selectList("approval.approvalDataSelect");
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

	@Override
	public int approvalSequence() {
		return sqlSession.selectOne("approval.approvalSequence");
	}
	
	@Override
	public void approverInsert(ApproverDto approverDto) {
		sqlSession.insert("approval.approverInsert", approverDto);
	}

	@Override
	public void agreeorInsert(AgreeorDto agreeorDto) {
		sqlSession.insert("approval.agreeorInsert", agreeorDto);
	}

	@Override
	public void recipientInsert(RecipientDto recipientDto) {
		sqlSession.insert("approval.recipientInsert", recipientDto);
	}

	@Override
	public void readerInsert(ReaderDto readerDto) {
		sqlSession.insert("approval.readerInsert", readerDto);
	}



}
