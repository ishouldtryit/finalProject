package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.component.EmpNoGenerator;
import com.kh.synergyZone.dto.EmployeeDto;

@Repository
public class EmployeeRepoImpl implements EmployeeRepo {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private EmpNoGenerator empNoGenerator;

	@Override
    public void insert(EmployeeDto employeeDto) {
        int deptNo = employeeDto.getDeptNo();
        String empNo = empNoGenerator.generateEmpNo(String.valueOf(deptNo));
        employeeDto.setEmpNo(empNo);
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

}
