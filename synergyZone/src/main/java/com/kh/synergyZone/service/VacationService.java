package com.kh.synergyZone.service;

import java.time.LocalDate;

public interface VacationService {
	//연차개수 계산
	int calculateVacationDays(LocalDate hireDate, LocalDate currentDate);
}
