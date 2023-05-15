package com.kh.synergyZone.component;

import java.time.Year;
import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class EmpNoGeneratorImpl implements EmpNoGenerator {
	
	private Random r = new Random();

	@Override
	public String generateEmpNo(String deptNo) {
		String year = String.valueOf(Year.now().getValue());
		String randomNum = generateRandomNo(3);
		
		return year + deptNo +  randomNum;
		
	}

	@Override
	public String generateRandomNo(int size) {
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i<size; i++) {
			buffer.append(r.nextInt(10));
		}
		return buffer.toString();
	}

}
