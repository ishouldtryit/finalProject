package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.DepartmentDto;

public interface DepartmentRepo {
	void insert(DepartmentDto departmentDto);
	List<DepartmentDto> list();
	void delete(int deptNo);
}
