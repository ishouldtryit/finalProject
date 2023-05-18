package com.kh.synergyZone.repo;

import java.sql.Date;
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
//        int deptNo = employeeDto.getDeptNo();
//        Date empHireDate = employeeDto.getEmpHireDate();
//        String empNo = empNoGenerator.generateEmpNo(String.valueOf(deptNo), empHireDate);
//        employeeDto.setEmpNo(empNo);
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
//		 int deptNo = employeeDto.getDeptNo();
//	     Date empHireDate = employeeDto.getEmpHireDate();
//	     String empNo = empNoGenerator.generateEmpNo(String.valueOf(deptNo), empHireDate);
//	     employeeDto.setEmpNo(empNo);
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
