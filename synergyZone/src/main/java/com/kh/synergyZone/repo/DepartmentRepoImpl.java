package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.DepartmentDto;

@Repository
public class DepartmentRepoImpl implements DepartmentRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(DepartmentDto departmentDto) {
		sqlSession.insert("department.save", departmentDto);
	}

	@Override
	public List<DepartmentDto> list() {
		return sqlSession.selectList("department.list");
	}

	@Override
	public void delete(int deptNo) {
		sqlSession.delete("department.delete", deptNo);
	}
	
	
}
