package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.MenuDto;

@Repository
public class MenuRepoImpl implements MenuRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(MenuDto menuDto) {
		sqlSession.insert("menu.insertMenu", menuDto);
	}
}
