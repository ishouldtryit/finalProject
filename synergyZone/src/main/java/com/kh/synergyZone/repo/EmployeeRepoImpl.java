package com.kh.synergyZone.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.PaginationVO;

@Repository
public class EmployeeRepoImpl implements EmployeeRepo {
   
   @Autowired
   private SqlSession sqlSession;
   
   @Autowired
   private PasswordEncoder encoder;
   
   //사원
   @Override
    public void insert(EmployeeDto employeeDto) {
	    String empPassword = "synergyZone12345";
		String encrypt = encoder.encode(empPassword);
		employeeDto.setEmpPassword(encrypt);
        sqlSession.insert("employee.save", employeeDto);
    }

   @Override
   public EmployeeDto selectOne(String empNo) {
      return sqlSession.selectOne("employee.find", empNo);
   }

   @Override
   public List<EmployeeInfoDto> list() {
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
   
   //퇴사
   @Override
   public void exit(String empNo) {
      EmployeeDto employeeDto = new EmployeeDto();
      employeeDto.setEmpNo(empNo);
      employeeDto.setIsLeave("Y");
      sqlSession.update("employee.exit", employeeDto);
   }
   

	@Override
	public void finalExit(EmployeeDto employeeDto) {
		sqlSession.update("employee.finalExit", employeeDto);
	}
   
   
   //퇴사 취소
   @Override
	public void cancelExit(String empNo) {
		EmployeeDto employeeDto = new EmployeeDto();
		employeeDto.setEmpNo(empNo);
		employeeDto.setIsLeave("N");
		sqlSession.update("employee.exit", employeeDto);
	}
   
   //비밀번호 찾기
   @Override
   public EmployeeDto findPw(String empNo, String empEmail) {
	   Map<String, String> params = new HashMap<>();
	   params.put("empNo", empNo);
	   params.put("empEmail", empEmail);
	   return sqlSession.selectOne("employee.findPw", params);
   }
   
   //비밀번호 변경
   @Override
   public void changePw(EmployeeDto employeeDto) {
	   sqlSession.update("employee.changePw", employeeDto);
   }
   
   //사원번호
   @Override
   public String lastEmpNoOfYear(String year) {
      return sqlSession.selectOne("employee.lastEmpNoOfYear",year);
   }
   
   //퇴사 대기목록
   @Override
   public List<EmployeeInfoDto> waitingList() {
      return sqlSession.selectList("employee.waitingList");
   }
   
   //사원 검색
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
   public List<EmployeeInfoDto> searchEmployees(String column, String keyword) {
	   Map<String, Object> params = new HashMap<>();
	   params.put("column", column);
	   params.put("keyword", keyword);
	   return sqlSession.selectList("employee.searchEmployees", params);
   }
   
   //퇴사대기자 목록
   @Override
   public int waitingEmployeesCount() {
	   return sqlSession.selectOne("employee.waitingEmployeesCount");
   }
   
   @Override
   public List<EmployeeInfoDto> WaitingEmployeeList(PaginationVO vo) {
	   	  int begin = vo.getBegin();
	      int end = vo.getEnd();

	      Map<String, Object> params = new HashMap<>();
	      params.put("begin", begin);
	      params.put("end", end);

	      return sqlSession.selectList("employee.getWaitingList", params);
   }
   
   @Override
   public List<EmployeeInfoDto> searchWaitingEmployees(String column, String keyword) {
	   Map<String, Object> params = new HashMap<>();
	   params.put("column", column);
	   params.put("keyword", keyword);
	   return sqlSession.selectList("searchWaitingEmployees", params);
   }
   
    //관리자 권한 부여
	@Override
	public boolean authorityAdmin(String empNo) {
		EmployeeDto employeeDto = new EmployeeDto();
		employeeDto.setEmpNo(empNo);
		employeeDto.setEmpAdmin("Y");
		return sqlSession.update("employee.authorityAdmin", employeeDto) > 0;
	}
	
	//관리자 목록
	@Override
	public List<EmployeeDto> adminList() {
		return sqlSession.selectList("employee.adminList");
	}

	//부서별 사원목록
	@Override
	public List<DeptEmpListVO> treeSelect(String empName) {
		  List<DeptEmpListVO> resultList = sqlSession.selectList("employee.treeSelect");
		  
		  for (DeptEmpListVO deptEmpListVO : resultList) {
		    List<EmployeeInfoDto> employeeList = sqlSession.selectList("employee.treeSelectSub", 
                            new HashMap<String, Object>() {/**
								 * 
								 */
								private static final long serialVersionUID = 1L;

							{
                                put("deptNo", deptEmpListVO.getDepartmentDto().getDeptNo());
                                put("empName", empName);
                            }});
		    deptEmpListVO.setEmployeeList(employeeList);
		  }
		  
		  return resultList;
	}

	@Override
	public EmployeeDto getId(String empNo) {
		return sqlSession.selectOne("employee.empId",empNo);
	}



}
