package com.kh.synergyZone.component;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomGeneratorImpl implements RandomGenerator {
	
	private Random r = new Random();
	
	@Override
	public String number(int size) {
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i<size; i++) {
			buffer.append(r.nextInt(10));
		}
		return buffer.toString();
	}
	
}
