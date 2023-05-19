package com.kh.synergyZone.repo;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.LoginRecordDto;

@Repository
public class LoginRecordRepoImpl implements LoginRecordRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(LoginRecordDto loginRecordDto) {
		loginRecordDto.setLogLogin(new Timestamp(System.currentTimeMillis()));
		
		sqlSession.insert("loginRecord.save", loginRecordDto);
	}

	@Override
	public List<LoginRecordDto> list() {
		return sqlSession.selectList("loginRecord.list");
	}
}
