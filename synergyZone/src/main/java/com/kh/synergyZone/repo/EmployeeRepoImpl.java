package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.EmployeeDto;

@Repository
public class EmployeeRepoImpl implements EmployeeRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(EmployeeDto employeeDto) {
		sqlSession.insert("employee.save", employeeDto);
	}

	@Override
	public EmployeeDto selectOne(String empNo) {
		return sqlSession.selectOne("employee.find", empNo);
	}

}
