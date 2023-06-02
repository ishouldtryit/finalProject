package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.vo.VacationVO;

@Repository
public class VacationRepoImpl implements VacationRepo {
	@Autowired
	private SqlSession sqlSession;
	
	//연차사용 리스트
	public List<VacationVO> selectList(VacationVO vo) {
		return sqlSession.selectList("vacation.list",vo);
	}
	
	//관리자
	@Override
	public List<VacationVO> adminList(VacationVO vo) {
		return sqlSession.selectList("vacation.adminList",vo);
	}
	
	//대기열
	@Override
	public List<VacationVO> queue(VacationVO vo) {
		return sqlSession.selectList("vacation.queue",vo);
	}

	//연차등록
	@Override
	public void insert(VacationVO vo) {
		sqlSession.insert("vacation.add",vo);
		
	}
	
}
