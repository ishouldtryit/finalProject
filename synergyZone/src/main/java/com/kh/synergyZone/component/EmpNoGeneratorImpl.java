package com.kh.synergyZone.component;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class EmpNoGeneratorImpl implements EmpNoGenerator {
	
	private Map<Integer, Integer> yearMap = new HashMap<>();
	
	@Override
	public String generateEmpNo(String deptNo, Date empHireDate) {
	    LocalDate hireDate = empHireDate.toLocalDate();
	    int year = hireDate.getYear();
	    int number = getNumber(year);

	    return year + String.format("%04d", number);
	}

	
	private int getNumber(int year) {
		if(yearMap.containsKey(year)) {
			int number = yearMap.get(year) + 1;
			yearMap.put(year, number);
			return number;
		}
		else {
			yearMap.put(year, 1);
			return 1;
		}
	}
//	
//	private void updateNumber(int year, int number) {
//		yearMap.put(year, number);
//	}

	
}
