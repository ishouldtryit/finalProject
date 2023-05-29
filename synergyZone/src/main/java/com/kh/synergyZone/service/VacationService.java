package com.kh.synergyZone.service;

import java.time.LocalDate;

public interface VacationService {
	int calculateVacationDays(LocalDate hireDate, LocalDate currentDate);
}
