package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ApprovalDto;

public interface ApprovalRepo {

	void insert(ApprovalDto approvalDto);
	List<ApprovalDto> selectList();
	ApprovalDto selectOne(int draftNo);
	void delete(int draftNo);
}
