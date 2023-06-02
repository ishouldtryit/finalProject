package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.SearchInfoDto;

public interface EmployeeInfoRepo {
		SearchInfoDto findAll(String empNo);
	    EmployeeInfoDto findByEmpNo(String empNo);
	    void save(EmployeeInfoDto employeeInfoDto);
	    void update(EmployeeInfoDto employeeInfoDto);
	    void deleteByEmpNo(String empNo);
}
