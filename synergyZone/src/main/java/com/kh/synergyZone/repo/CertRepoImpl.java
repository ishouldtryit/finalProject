package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.CertDto;

@Repository
public class CertRepoImpl implements CertRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(CertDto certDto) {
		sqlSession.insert("cert.add", certDto);
	}

	@Override
	public boolean exist(CertDto certDto) {
		CertDto findDto = sqlSession.selectOne("cert.checkSecretWithTime", certDto);
		return findDto != null;
	}

	@Override
	public void delete(CertDto certDto) {
		sqlSession.delete("cert.delete", certDto);
	}
	
	@Override
	public void clean() {
		sqlSession.delete("cert.clean");
	}
}
