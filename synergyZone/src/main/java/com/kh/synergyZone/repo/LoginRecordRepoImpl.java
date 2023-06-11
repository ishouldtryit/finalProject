package com.kh.synergyZone.repo;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.LoginRecordDto;
import com.kh.synergyZone.dto.LoginRecordInfoDto;
import com.kh.synergyZone.vo.LoginRecordSearchVO;
import com.kh.synergyZone.vo.PaginationVO;

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
	public List<LoginRecordInfoDto> list() {
		return sqlSession.selectList("loginRecord.list");
	}

//	@Override
//	public List<LoginRecordInfoDto> logList(LoginRecordSearchVO vo) {
//		return sqlSession.selectList("loginRecord.complexSearch", vo);
//	}

	@Override
	public int selectCount(PaginationVO vo) {
		return sqlSession.selectOne("loginRecord.count", vo);
	}

	@Override
	public List<LoginRecordInfoDto> selectListByPaging(PaginationVO vo) {
		return sqlSession.selectList("loginRecord.complexSearch", vo);
	}
}
