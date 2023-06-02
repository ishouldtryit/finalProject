package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.SearchInfoDto;

@Repository
public class EmployeeInfoRepoImpl implements EmployeeInfoRepo {

    private final SqlSession sqlSession;

    @Autowired
    public EmployeeInfoRepoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }


    @Override
    public EmployeeInfoDto findByEmpNo(String empNo) {
        return sqlSession.selectOne("empInfo.findByEmpNo", empNo);
    }

    @Override
    public void save(EmployeeInfoDto employeeInfoDto) {
        sqlSession.insert("empInfo.save", employeeInfoDto);
    }

    @Override
    public void update(EmployeeInfoDto employeeInfoDto) {
        sqlSession.update("empInfo.update", employeeInfoDto);
    }

    @Override
    public void deleteByEmpNo(String empNo) {
        sqlSession.delete("empInfo.deleteByEmpNo", empNo);
    }


	@Override
	public SearchInfoDto findAll(String empNo) {
		return sqlSession.selectOne("empInfo.findAll", empNo);
	}
}
