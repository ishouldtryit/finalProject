package com.kh.synergyZone.vo;

import java.util.List;

import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class DeptEmpListVO {

	private DepartmentDto departmentDto;
	private List<EmployeeDto> employeeList;
	
}
