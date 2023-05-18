package com.kh.synergyZone.repo;

import java.util.List;

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

	@Override
	public List<EmployeeDto> list() {
		return sqlSession.selectList("employee.list");
	}

	@Override
	public void delete(String empNo) {
		sqlSession.delete("employee.delete", empNo);
	}

	@Override
	public void update(EmployeeDto employeeDto) {
		sqlSession.update("employee.edit", employeeDto);
	}

	@Override
	public void exit(String empNo) {
		EmployeeDto employeeDto = new EmployeeDto();
		employeeDto.setEmpNo(empNo);
		employeeDto.setIsLeave("Y");
		sqlSession.update("employee.exit", employeeDto);
	}

	@Override
	public String lastEmpNoOfYear(String year) {
		return sqlSession.selectOne("employee.lastEmpNoOfYear",year);
	}

}
