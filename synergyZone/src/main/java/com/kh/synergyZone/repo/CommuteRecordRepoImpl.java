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
	public void insert(CommuteRecordDto dto) {
		sqlSession.insert("commuteRecord.start",dto);
		
	}
	@Override
	public boolean update(CommuteRecordDto dto) {
		return sqlSession.update("commuteRecord.end",dto)>0;
	}

	//춭퇴근 단일
	@Override
	public CommuteRecordDto today(String empNo) {
		return sqlSession.selectOne("commuteRecord.today",empNo);
	}

	@Override
	public List<CommuteRecordDto> allList(String empNo) {
		return sqlSession.selectList("commuteRecord.empRecordList",empNo);
	}
	@Override
	public boolean delete(CommuteRecordDto dto) {
		return sqlSession.delete("commuteRecord.delete",dto)>0;
	}

	
	
}
