package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.TripDto;

@Repository
public class TripRepoImpl implements TripRepo{

	@Autowired
	private SqlSession session;

	//등록
	@Override
	public void insert(TripDto tripDto) {
		session.insert("trip.insert",tripDto);
	}

	//개인 출장 리스트조회
	@Override
	public List<TripDto> list(TripDto dto) {
		return session.selectList("trip.tripList",dto);
	}
	@Override
	public List<TripDto> queue(String empNo) {
		return session.selectList("trip.queue",empNo);
	}
	@Override
	public List<TripDto> adminList() {
		return session.selectList("trip.adminList");
		
	}
	
	
}
