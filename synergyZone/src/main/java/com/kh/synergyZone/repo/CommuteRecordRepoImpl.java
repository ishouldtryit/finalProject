package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.CommuteRecordDto;

@Repository
public class CommuteRecordRepoImpl implements CommuteRecordRepo{
	@Autowired
	private SqlSession sqlSession;

	
	//출근시간
	@Override
	public void insert(CommuteRecordDto commuteRecordDto) {
		sqlSession.insert("commuteRecord.start",commuteRecordDto);
		
	}

	// 퇴근시간
	@Override
	public boolean update(CommuteRecordDto commuteRecordDto) {
		return sqlSession.update("commuteRecord.end",commuteRecordDto)>0;
	}
	
	
}
