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
	
}
