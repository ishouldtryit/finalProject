package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.EmployeeProfileDto;

@Repository
public class EmployeeProfileRepoImpl implements EmployeeProfileRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(EmployeeProfileDto employeeProfileDto) {
		sqlSession.insert("empProfile.insertProfile", employeeProfileDto);
	}

	@Override
	public void delete(String empNo) {
		sqlSession.delete("empProfile.deleteProfile", empNo);
	}

	@Override
	public void update(String empNo) {
		sqlSession.update("empProfile.updateProfile", empNo);
	}
	
	@Override
	public EmployeeProfileDto find(String empNo) {
	    List<EmployeeProfileDto> profiles = sqlSession.selectList("empProfile.find", empNo);
	    if (profiles != null && !profiles.isEmpty()) {
	        return profiles.get(0);
	    }
	    return null;
	}



}
