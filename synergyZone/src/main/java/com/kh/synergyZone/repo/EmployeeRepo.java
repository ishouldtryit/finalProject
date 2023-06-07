package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.vo.DeptEmpListVO;
import com.kh.synergyZone.vo.PaginationVO;

public interface EmployeeRepo {
	   //사원
	   void insert(EmployeeDto employeeDto);
	   EmployeeDto selectOne(String empNo);
	   List<EmployeeInfoDto> list();
	   void update(EmployeeDto employeeDto);
	   void exit(String empNo);
	   void cancelExit(String empNo);
	   void delete(String empNo);
	   
	   //부서별 사원목록
	   List<DeptEmpListVO> treeSelect(String empName);
	   
	   //비밀번호 찾기
	   EmployeeDto findPw(@Param("empNo") String empNo, @Param("empEmail") String empEmail);
	   
	   //비밀번호 변경
	   void changePw(EmployeeDto employeeDto);

	   //사원번호
	   String lastEmpNoOfYear(String year);
	   
	   //퇴사 대기목록
	   List<EmployeeInfoDto> waitingList();
	   
	   //관리자 권한 부여
	   boolean authorityAdmin(String empNo);
	   
	   //관리자 목록
	   List<EmployeeDto> adminList();
	   
	   //사원 검색
	   int getCount();
	   List<EmployeeDto> getEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchEmployees(String column, String keyword);
	   
	   //퇴사자 목록 검색
	   int waitingEmployeesCount();
	   List<EmployeeInfoDto> WaitingEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchWaitingEmployees(String column, String keyword);
	   
	   
	
}