package com.kh.synergyZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class SynergyZoneApplication {

	public static void main(String[] args) {
		SpringApplication.run(SynergyZoneApplication.class, args);
	}

}
