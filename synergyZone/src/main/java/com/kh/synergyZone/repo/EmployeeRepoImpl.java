package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.component.EmpNoGenerator;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.PaginationVO;

@Repository
public class EmployeeRepoImpl implements EmployeeRepo {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private EmpNoGenerator empNoGenerator;

    public EmployeeRepoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
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

	@Override
	public int getCount() {
        return sqlSession.selectOne("employee.count");
	}

	@Override
	public List<EmployeeDto> getEmployeeList(PaginationVO vo) {

        int begin = vo.getBegin();
        int end = vo.getEnd();

        Map<String, Object> params = new HashMap<>();
        params.put("begin", begin);
        params.put("end", end);
        
        return sqlSession.selectList("employee.getEmployeeList", params); 
	}

	@Override
	public List<EmployeeDto> searchEmployees(String column, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("column", column);
        params.put("keyword", keyword);
        return sqlSession.selectList("searchEmployees", params);
    }
	
	public void update(EmployeeDto employeeDto) {
		sqlSession.update("employee.edit", employeeDto);
	}
	
	@Override
	public List<DeptEmpListVO> treeSelect() {
		return sqlSession.selectList("employee.treeSelect");
	}

}
