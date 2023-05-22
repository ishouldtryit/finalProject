package com.kh.synergyZone.component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

@Component
public class RandomComponent {
	private List<String> data = new ArrayList<>();
	private Random r = new Random();
	
	@PostConstruct
	public void init() {
		for(char i='A'; i <= 'Z'; i++) 	data.add(String.valueOf(i));
		for(char i='a'; i <= 'z'; i++) 	data.add(String.valueOf(i));
		for(char i='0'; i <= '9'; i++) 	data.add(String.valueOf(i));
		data.add("!");
		data.add("@");
		data.add("#");
		data.add("$");
	}
	
	public String generateString() {
		StringBuffer buffer = new StringBuffer();
		while(true) {
			int size = r.nextInt(8, 16);
			buffer.setLength(0);
			for(int i = 0; i < size; i ++) {
				int index = r.nextInt(data.size());
				buffer.append(data.get(index));
			}
			if(buffer.toString().matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*?=+_-])[A-Za-z0-9!@#$%^&*?=+_-]{8,16}$")) {
				break;
			}
		}
		return buffer.toString();
	}
}
