package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.VacationInfo;

//사원 연차정보
@Repository
public class VacationInfoRepoImpl implements VacationInfoRepo{

	@Autowired
	private SqlSession session;

	@Override
	public void add(VacationInfo info) {
		//사원 연차정보 추가 (시점은 가입시)
		session.insert("vacationInfo.add",info);
	}

	//연차정보 사원 단일조회
	@Override
	public VacationInfo one(String empNo) {
		return session.selectOne("vacationInfo.one",empNo);
	}

	//사용시 연차 정보 변경
	@Override
	public boolean used(VacationInfo info) {
		return session.update("vacationInfo.used")>0;
		
	}

	//스케쥴링 연차정보 초기화
	@Override
	public boolean scheduling(VacationInfo info) {
		return session.update("vacationInfo.")>0;
		
		
	}


	
	
}
