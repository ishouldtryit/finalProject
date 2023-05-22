package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.VacationDto;

@Repository
public class VacationRepoImpl implements VacationRepo {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<VacationDto> selectList() {
		return sqlSession.selectList("");
	}
	
}
