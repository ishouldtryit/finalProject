package com.kh.synergyZone.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;

public interface VacationService {
	//연차개수 계산
	int calculateVacationDays(Date joinDateStr);
	String getLocation(HttpServletRequest request);
}
