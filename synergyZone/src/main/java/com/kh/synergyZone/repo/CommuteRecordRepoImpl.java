package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.CommuteRecordDto;

@Repository
public class CommuteRecordRepoImpl implements CommuteRecordRepo{
	@Autowired
	private SqlSession sqlSession;

	
	//출퇴근
	@Override
	public void insert(CommuteRecordDto commuteRecordDto) {
		sqlSession.insert("commuteRecord.start",commuteRecordDto);
		
	}
	@Override
	public boolean update(CommuteRecordDto commuteRecordDto) {
		return sqlSession.update("commuteRecord.end",commuteRecordDto)>0;
	}

	//춭퇴근 단일 / 리스트 조회
	@Override
	public CommuteRecordDto today(String empNo) {
		return sqlSession.selectOne("commuteRecord.today",empNo);
	}

	@Override
	public List<CommuteRecordDto> allList(String empNo) {
		return sqlSession.selectList("commuteRecord.allList",empNo);
	}
	
	
}
