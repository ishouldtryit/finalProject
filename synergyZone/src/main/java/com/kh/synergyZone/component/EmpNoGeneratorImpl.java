package com.kh.synergyZone.component;

import java.time.Year;
import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class EmpNoGeneratorImpl implements EmpNoGenerator {

	private Random r = new Random();
	private int sequence = 0;
	private int currentYear = Year.now().getValue();

	@Override
	public String generateEmpNo(String deptNo) {
		String year = String.valueOf(Year.now().getValue());
		
		if(currentYear != Year.now().getValue()) {
			resetSequence();
			currentYear = Year.now().getValue();
		}
		
		String sequenceNumber = generateSequenceNumber();

		return year + deptNo + sequenceNumber;

	}

	private synchronized String generateSequenceNumber() {
		sequence++;
		if (sequence > 999) {
			sequence = 0;
		}
		return String.format("%03d", sequence);
	}
	
	private synchronized void resetSequence() {
		sequence = 0;
	}
//
//	@Override
//	public String generateRandomNo(int size) {
//		StringBuffer buffer = new StringBuffer();
//		for (int i = 0; i < size; i++) {
//			buffer.append(r.nextInt(10));
//		}
//		return buffer.toString();
//	}
}