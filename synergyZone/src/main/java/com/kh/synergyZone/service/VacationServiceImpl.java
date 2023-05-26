package com.kh.synergyZone.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class VacationServiceImpl implements VacationService {
	
	//1년차 기본 연차일수
	private static int baseVacationDays = 15;

    @Override
    public int calculateVacationDays(LocalDate hireDate, LocalDate currentDate) {
    	
        long yearsOfService = ChronoUnit.YEARS.between(hireDate, currentDate);
        int remainingMonths = currentDate.getMonthValue() - hireDate.getMonthValue();

        int vacationDays;
        if (yearsOfService == 0) {
            vacationDays = remainingMonths + baseVacationDays;
        } else {
            vacationDays = baseVacationDays + (int) ((2 * yearsOfService) - 1);
            vacationDays += (yearsOfService / 2) - 1; // 등차수열로 증가하는 경우 추가 연차 적용
        }

        return vacationDays;
    }
}