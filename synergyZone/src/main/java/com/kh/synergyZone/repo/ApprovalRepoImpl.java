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
import com.kh.synergyZone.vo.ApprovalPaginationVO;

@Repository
public class ApprovalRepoImpl implements ApprovalRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ApprovalDto approvalDto) {
		sqlSession.insert("approval.insert",approvalDto);
	}

	@Override
	public ApprovalDataVO approvalDataSelectOne(int draftNo) {
		return sqlSession.selectOne("approval.approvalDataSelectOne", draftNo);
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
	
	@Override
	public int approvalDataCount(ApprovalPaginationVO vo) {
		return sqlSession.selectOne("approval.approvalDataCount", vo);
	}
	
	@Override
	public List<ApprovalDataVO> approvalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.approvalDataSelectList", vo);
	}
	
	@Override
	public int myApprovalDataCount(ApprovalPaginationVO vo) {
		return sqlSession.selectOne("approval.myApprovalDataCount", vo);
	}

	@Override
	public List<ApprovalDataVO> myApprovalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.myApprovalDataSelectList", vo);
	}

	@Override
	public int waitApproverApprovalDataCount(ApprovalPaginationVO vo) {
		 return sqlSession.selectOne("approval.waitApproverApprovalDataCount", vo);
	}

	@Override
	public List<ApprovalDataVO> waitApproverApprovalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.waitApproverApprovalDataSelectList", vo);
	}

	@Override
	public int waitAgreeorApprovalDataCount(ApprovalPaginationVO vo) {
		return sqlSession.selectOne("approval.waitAgreeorApprovalDataCount", vo);
	}

	@Override
	public List<ApprovalDataVO> waitAgreeorApprovalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.waitAgreeorApprovalDataSelectList", vo);
	}

	@Override
	public int recipientApprovalDataCount(ApprovalPaginationVO vo) {
		return sqlSession.selectOne("approval.recipientApprovalDataCount", vo);
	}

	@Override
	public List<ApprovalDataVO> recipientApprovalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.recipientApprovalDataSelectList", vo);
	}

	@Override
	public int readerApprovalDataCount(ApprovalPaginationVO vo) {
		return sqlSession.selectOne("approval.readerApprovalDataCount", vo);
	}

	@Override
	public List<ApprovalDataVO> readerApprovalDataSelectList(ApprovalPaginationVO vo) {
		return sqlSession.selectList("approval.readerApprovalDataSelectList", vo);
	}

	@Override
	public void recallApproval(int draftNo) {
		sqlSession.update("approval.recallApproval", draftNo);
	}

	@Override
	public void reApproval(int draftNo) {
		sqlSession.update("approval.reApproval", draftNo);
	}




}
