package com.kh.synergyZone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired
	private EmployeeRepo employeeRepo;

	@Override
	public void join(EmployeeDto employeeDto) {
		employeeRepo.insert(employeeDto);
	}

	@Override
	public EmployeeDto login(EmployeeDto employeeDto) {
		String empNo = employeeDto.getEmpNo();
		EmployeeDto findDto = employeeRepo.selectOne(empNo);
		
		if(findDto == null) return null;
		
		if(findDto.getEmpPassword().equals(employeeDto.getEmpPassword())) {
			return findDto;
		}
		return null;
	}


	
}
