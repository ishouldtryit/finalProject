package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.VacationDto;
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
	public List<VacationVO> adminList() {
		return sqlSession.selectList("vacation.adminList");
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
	
	
	@Override
	public VacationVO oneList(int vacationNo) {
		return sqlSession.selectOne("vacation.oneList",vacationNo);
	}

	
	@Override
	public boolean appoval(VacationDto dto) {
		return sqlSession.update("vacation.appoval",dto)>0;

		
	}
	
}
