package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.vo.PaginationVO;

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

   @Override
   public List<EmployeeDto> waitingList() {
      return sqlSession.selectList("employee.waitingList");
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

	@Override
	public EmployeeDto findPw(String empNo, String empEmail) {
		Map<String, String> params = new HashMap<>();
		params.put("empNo", empNo);
		params.put("empEmail", empEmail);
		return sqlSession.selectOne("employee.findPw", params);
	}

	@Override
	public void changePw(EmployeeDto employeeDto) {
		sqlSession.update("employee.changePw", employeeDto);
	}

}