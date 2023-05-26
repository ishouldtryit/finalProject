package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.VacationInfo;

@Repository
public class VacationInfoRepoImpl implements VacationInfoRepo{

	@Autowired
	private SqlSession session;

	@Override
	public void add(VacationInfo info) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public VacationInfo one(String empNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void used(VacationInfo info) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void scheduling(VacationInfo info) {
		// TODO Auto-generated method stub
		
	}


	
	
}
