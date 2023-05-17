package com.kh.synergyZone.component;

import java.sql.Date;

public interface EmpNoGenerator {
	String generateEmpNo(String deptNo, Date empHireDate);
	
}