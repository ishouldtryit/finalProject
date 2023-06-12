package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.TripPersonDto;

@Repository
public class TripPersonRepoImpl implements TripPersonRepo{
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(TripPersonDto personDto) {
		session.insert("trip.personInsert",personDto);
		
	}

	@Override
	public List<TripPersonDto> list(int tripNo) {
		return session.selectList("trip.personList",tripNo);
	}

	@Override
	public String one(String empNo) {
		return session.selectOne("trip.no",empNo);
	}
	
}
