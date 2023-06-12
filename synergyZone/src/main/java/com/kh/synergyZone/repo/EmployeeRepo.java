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
	   
	   //사원의 정보 수정
	   void employeeUpdate(EmployeeDto employeeDto);
	   
	   //관리자의 정보 수정
	   void update(EmployeeDto employeeDto);
	   
	   
	   //부서별 사원목록
	   List<DeptEmpListVO> treeSelect(String empName);
	   
	   //비밀번호 찾기
	   EmployeeDto findPw(@Param("empNo") String empNo, @Param("empEmail") String empEmail);
	   
	   //비밀번호 변경
	   void changePw(EmployeeDto employeeDto);

	   //사원번호
	   String lastEmpNoOfYear(String year);
	 
	   //관리자 권한 부여
	   boolean authorityAdmin(String empNo);
	   boolean deleteAdmin(String empNo);
	   
	   //관리자 목록
	   List<EmployeeInfoDto> adminList();
	   List<EmployeeInfoDto> searchAdminList(String column, String keyword);
	   
	   //사원 검색
	   int getCount();
	   List<EmployeeDto> getEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchEmployees(String column, String keyword);
	   
	   //퇴사 대기
	   void exit(String empNo);
	   void delete(String empNo);
	   
	   List<EmployeeInfoDto> waitingList();
	   int waitingEmployeesCount();
	   List<EmployeeInfoDto> WaitingEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchWaitingEmployees(String column, String keyword);
	   
	   //최종 퇴사
	   void finalExit(EmployeeDto employeeDto);
	   
	   List<EmployeeInfoDto> exitList();
	   int exitEmployeesCount();
	   List<EmployeeInfoDto> exitEmployeeList(PaginationVO vo);
	   List<EmployeeInfoDto> searchExitEmployees(String column, String keyword);
	   
	   //퇴사 취소
	   void cancelExit(String empNo);
	  
	   //아이디조회
	   EmployeeDto getId(String empNo);
	   
	
}