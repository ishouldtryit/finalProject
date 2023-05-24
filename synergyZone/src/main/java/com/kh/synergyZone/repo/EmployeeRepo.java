package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.vo.PaginationVO;

public interface EmployeeRepo {
	   //사원
	   void insert(EmployeeDto employeeDto);
	   EmployeeDto selectOne(String empNo);
	   List<EmployeeDto> list();
	   void update(EmployeeDto employeeDto);
	   void exit(String empNo);
	   void delete(String empNo);
	   
	   //비밀번호 찾기
	   EmployeeDto findPw(String empNo, String empEmail);
	   
	   //비밀번호 변경
	   void changePw(String empNo, String empPassword);

	   //사원번호
	   String lastEmpNoOfYear(String year);
	   
	   //퇴사 대기목록
	   List<EmployeeDto> waitingList();
	   
	   //관리자 권한 부여
	   void authorityAdmin(String empNo);
	   
	   //사원 검색
	   int getCount();
	        List<EmployeeDto> getEmployeeList(PaginationVO vo);
	   List<EmployeeDto> searchEmployees(String column, String keyword);
	   
	   
	
}