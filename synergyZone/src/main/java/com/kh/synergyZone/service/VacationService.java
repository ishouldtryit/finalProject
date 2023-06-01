package com.kh.synergyZone.service;

import java.sql.Date;

public interface VacationService {
	//연차개수 계산
	int calculateVacationDays(Date joinDateStr);

}
